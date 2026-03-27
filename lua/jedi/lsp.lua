local M = {}

function M.setup()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("*", {
    capabilities = capabilities,
  })

  vim.lsp.config("clangd", {
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
  })

  vim.lsp.config("lua_ls", {
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
          path = {
            "lua/?.lua",
            "lua/?/init.lua",
          },
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
        diagnostics = {
          globals = {
            "vim",
            "require",
          },
        },
        telemetry = { enable = false },
      },
    },
  })

  vim.lsp.config("gopls", {
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
  })

  -- vim.lsp.config("ts_ls", {})

  vim.lsp.enable({ "clangd", "gopls", "rust_analyzer", "lua_ls" })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local k = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = 0, desc = "LSP: " .. desc })
      end
      local lazy_call = require("jedi.utils").lazy_call

      k("K", vim.lsp.buf.hover, "Hover")
      k("gd", lazy_call("fzf-lua", "lsp_definitions"), "Jump to definition")
      k("gs", lazy_call("fzf-lua", "lsp_document_symbols"), "Symbols")
      k("gS", lazy_call("fzf-lua", "lsp_workspace_symbols"), "Workspace symbols")
      k("gl", lazy_call("fzf-lua", "lsp_live_workspace_symbols"), "Live workspace symbols")
      k("gD", vim.lsp.buf.declaration, "Jump to declaration")
      k("gT", vim.lsp.buf.type_definition, "Jump to type definition")
      k("gn", vim.lsp.buf.rename, "Rename")
      k("ga", vim.lsp.buf.code_action, "Code action")
      k("<space>ca", vim.lsp.buf.code_action, "Code action")
      k("<C-x>", vim.lsp.buf.signature_help, "Signature help", "i")
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

  local function open_float()
    vim.diagnostic.open_float({ scope = "line" })
  end

  vim.keymap.set("n", "[d", jump_to_error("prev"), { desc = "Jump to previous error", silent = true })
  vim.keymap.set("n", "]d", jump_to_error("next"), { desc = "Jump to next error", silent = true })
  vim.keymap.set("n", "<leader>a", open_float, { desc = "Line Diagnostics", silent = true })
end

return M
