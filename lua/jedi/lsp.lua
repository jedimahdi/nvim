local fzf = require("fzf-lua")

local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp_nvim_lsp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

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

vim.lsp.enable({ "lua_ls", "clangd", "gopls" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, silent = true })
    vim.keymap.set("n", "gd", fzf.lsp_definitions, { buffer = 0 })
    -- vim.keymap.set("n", "grr", fzf.lsp_references, { buffer = 0 })
    vim.keymap.set("n", "gs", fzf.lsp_document_symbols, { buffer = 0 })
    vim.keymap.set("n", "gS", fzf.lsp_workspace_symbols, { buffer = 0 })
    vim.keymap.set("n", "gl", fzf.lsp_live_workspace_symbols, { buffer = 0 })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "gn", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("i", "<C-x>", vim.lsp.buf.signature_help, { buffer = 0 })
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })

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

vim.keymap.set("n", "[d", function()
  local diags = vim.diagnostic.get(0, {})
  if #diags <= 0 then
    return
  end
  vim.diagnostic.jump({
    severity = get_highest_error_severity(),
    wrap = true,
    float = true,
    count = -1,
  })
end)
vim.keymap.set("n", "]d", function()
  local diags = vim.diagnostic.get(0, {})
  if #diags <= 0 then
    return
  end
  vim.diagnostic.jump({
    severity = get_highest_error_severity(),
    wrap = true,
    float = true,
    count = 1,
  })
end)
vim.keymap.set("n", "<leader>a", function()
  vim.diagnostic.open_float({
    scope = "line",
  })
end)
