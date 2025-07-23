local lspconfig = require("lspconfig")
local fzf = require("fzf-lua")

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = ok and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = false

local servers = {
  lua_ls = {
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
  },
  gopls = {
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
  ts_ls = {
    server_capabilities = {
      documentFormattingProvider = false,
    },
  },
  clangd = {
    cmd = {
      "clangd",
      "--log=error",
      "--background-index",
      "--header-insertion=never",
      "--clang-tidy=false",
      "--completion-style=bundled",
      "--function-arg-placeholders=false",
      "--query-driver=/usr/bin/gcc,/usr/bin/clang",
    },
    init_options = {
      clangdFileStatus = false,
      fallbackFlags = { "-std=c11", "-D_POSIX_C_SOURCE=200809L", "-D_GNU_SOURCE", "-x", "c" },
    },
  },
  ols = true,
}

local disable_semantic_tokens = {
  lua = true,
  c = true,
}

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {}, config or {}, { capabilities = capabilities })

  lspconfig[name].setup(config)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    local config = servers[client.name]
    if type(config) ~= "table" then
      config = {}
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "gd", fzf.lsp_definitions, { buffer = 0 })
    vim.keymap.set("n", "grr", fzf.lsp_references, { buffer = 0 })
    -- vim.keymap.set("n", "gs", fzf.lsp_ocument_symbols, { buffer = 0 })
    vim.keymap.set("n", "gS", fzf.lsp_workspace_symbols, { buffer = 0 })
    vim.keymap.set("n", "gl", fzf.lsp_live_workspace_symbols, { buffer = 0 })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "gn", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("i", "<C-x>", vim.lsp.buf.signature_help, { buffer = 0 })
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })

    local filetype = vim.bo[bufnr].filetype
    if disable_semantic_tokens[filetype] then
      client.server_capabilities.semanticTokensProvider = nil
    end

    if config.server_capabilities then
      for k, v in pairs(config.server_capabilities) do
        if v == vim.NIL then
          ---@diagnostic disable-next-line: cast-local-type
          v = nil
        end

        client.server_capabilities[k] = v
      end
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
