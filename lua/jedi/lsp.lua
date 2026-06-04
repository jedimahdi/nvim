local M = {}

local servers = {
  clangd = {
    enabled = true,
    filetypes = { "c" },
    config = {
      cmd = {
        "clangd",
        "--log=error",
        "--background-index",
        "--header-insertion=never",
        "--clang-tidy=false",
        "--completion-style=detailed",
        "--function-arg-placeholders=false",
      },
      init_options = {
        clangdFileStatus = false,
        fallbackFlags = { "-std=c11", "-D_POSIX_C_SOURCE=200809L", "-D_GNU_SOURCE", "-x", "c" },
      },
    },
  },
  gopls = {
    enabled = false,
    filetypes = { "go" },
    config = {
      settings = {
        gopls = {
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    },
  },
  lua_ls = {
    enabled = true,
    filetypes = { "lua" },
    config = {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath("config")
            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            version = "LuaJIT",
            path = { "lua/?.lua", "lua/?/init.lua" },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
        })
      end,
      settings = {
        Lua = {
          format = { enable = false },
          diagnostics = { globals = { "vim" } },
          telemetry = { enable = false },
        },
      },
    },
  },
  rust_analyzer = {
    enabled = false,
    filetypes = { "rust" },
  },
  zls = {
    enabled = true,
    filetypes = { "zig" },
  },
}

local function enabled_server_names()
  local names = {}
  for name, server in pairs(servers) do
    if server.enabled then
      table.insert(names, name)
    end
  end
  return names
end

function M.filetypes()
  local seen = {}
  local filetypes = {}

  for name, server in pairs(servers) do
    if server.enabled then
      for _, filetype in ipairs(server.filetypes or {}) do
        if not seen[filetype] then
          seen[filetype] = true
          table.insert(filetypes, filetype)
        end
      end
    end
  end

  return filetypes
end

function M.setup()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("*", {
    capabilities = capabilities,
  })

  for name, server in pairs(servers) do
    vim.lsp.config(
      name,
      vim.tbl_extend("keep", { filetypes = server.filetypes }, server.config or {})
    )
  end

  vim.lsp.enable(enabled_server_names())

  vim.api.nvim_create_user_command("LspDisableSession", function()
    vim.lsp.enable(enabled_server_names(), false)

    for _, client in ipairs(vim.lsp.get_clients()) do
      client:stop(true)
    end

    vim.notify("LSP disabled for this Neovim session")
  end, {
    desc = "Stop all LSP clients and disable autostart for this session",
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local k = function(keys, func, desc, opts)
        opts = opts or {}
        local mode = opts.mode or "n"
        opts.mode = nil
        opts.buffer = 0
        opts.silent = opts.silent ~= false
        opts.noremap = opts.noremap ~= false
        if desc then
          opts.desc = "LSP: " .. desc
        end

        vim.keymap.set(mode, keys, func, opts)
      end

      -- k("K", vim.lsp.buf.hover, "Hover")
      k("gd", function() require("fzf-lua").lsp_definitions() end, "Jump to definition")
      k("gs", function() require("fzf-lua").lsp_document_symbols() end, "Symbols")
      k("gS", function() require("fzf-lua").lsp_workspace_symbols() end, "Workspace symbols")
      k(
        "gl",
        function() require("fzf-lua").lsp_live_workspace_symbols() end,
        "Live workspace symbols"
      )
      k("gD", vim.lsp.buf.declaration, "Jump to declaration")
      k("gT", vim.lsp.buf.type_definition, "Jump to type definition")
      k("gn", vim.lsp.buf.rename, "Rename")
      k("ga", vim.lsp.buf.code_action, "Code action")
      k("<space>ca", vim.lsp.buf.code_action, "Code action")
      k("<C-x>", vim.lsp.buf.signature_help, "Signature help", { mode = "i" })
      -- vim.keymap.set("n", "grr", fzf.lsp_references, { buffer = 0 })

      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then
        return
      end

      if client.name == "clangd" or client.name == "lua_ls" then
        client.server_capabilities.semanticTokensProvider = nil
      end

      if client.name == "ts_ls" then
        client.server_capabilities.documentFormattingProvider = false
      end
    end,
  })

  vim.diagnostic.config({
    underline = false,
    signs = false,
    severity_sort = true,
    update_in_insert = false,
  })

  local severity_levels = {
    vim.diagnostic.severity.ERROR,
    vim.diagnostic.severity.WARN,
    vim.diagnostic.severity.INFO,
    vim.diagnostic.severity.HINT,
  }

  local get_highest_error_severity = function()
    for _, level in ipairs(severity_levels) do
      local diags = vim.diagnostic.get(0, { severity = { min = level } })
      if #diags > 0 then
        return level, diags
      end
    end
  end

  local jump_to_error = function(direction)
    return function()
      local count = direction == "next" and 1 or -1
      local diags = vim.diagnostic.get(0, {})
      if #diags <= 0 then
        return
      end
      vim.diagnostic.jump({
        severity = get_highest_error_severity(),
        wrap = true,
        float = true,
        count = count,
      })
    end
  end

  local function open_float() vim.diagnostic.open_float({ scope = "line" }) end
  local function k(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true }) end

  k("[d", jump_to_error("prev"), "Jump to previous error")
  k("]d", jump_to_error("next"), "Jump to next error")
  k("<leader>a", open_float, "Line Diagnostics")
end

return M
