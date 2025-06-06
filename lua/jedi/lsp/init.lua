local lspconfig = require("lspconfig")
local utils = require("jedi.utils")
local fn = utils.fn

local capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities()
end

local servers = {
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            "${3rd}/luv/library",
          },
        },
      })
    end,
    settings = {
      Lua = {
        telemetry = { enable = false },
      },
    },
    server_capabilities = {
      semanticTokensProvider = vim.NIL,
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
    init_options = { clangdFileStatus = true },
  },
  ols = true,
}

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {}, {
    capabilities = capabilities,
  }, config)

  lspconfig[name].setup(config)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    local config = servers[client.name]
    if type(config) ~= "table" then
      config = {}
    end

    local builtin = require("telescope.builtin")

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.keymap.set("n", "K", fn(vim.lsp.buf.hover, { silent = true }), { buffer = 0 })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "gn", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("i", "<C-x>", vim.lsp.buf.signature_help, { buffer = 0 })

    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
    -- vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })

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
