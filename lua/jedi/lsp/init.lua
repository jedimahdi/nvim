local lspconfig = require("lspconfig")

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
      Lua = {},
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
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
    init_options = { clangdFileStatus = true },
  },
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

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
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

-- local servers = { "gopls", "zls", "clangd", "ts_ls" }
--
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--   })
-- end
--
-- lspconfig.lua_ls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   on_init = function(client)
--     if client.workspace_folders then
--       local path = client.workspace_folders[1].name
--       if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
--         return
--       end
--     end
--
--     client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
--       runtime = {
--         -- Tell the language server which version of Lua you're using
--         -- (most likely LuaJIT in the case of Neovim)
--         version = "LuaJIT",
--       },
--       -- Make the server aware of Neovim runtime files
--       workspace = {
--         checkThirdParty = false,
--         library = {
--           vim.env.VIMRUNTIME,
--           -- Depending on the usage, you might want to add additional paths here.
--           "${3rd}/luv/library",
--           -- "${3rd}/busted/library",
--         },
--         -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
--         -- library = vim.api.nvim_get_runtime_file("", true)
--       },
--     })
--   end,
--   settings = {
--     Lua = {},
--   },
-- })

-- lspconfig.hls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })

-- lspconfig.nil_ls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     ["nil"] = {
--       nix = {
--         -- maxMemoryMB = 7680,
--         flake = {
--           autoArchive = false,
--           autoEvalInputs = false,
--         },
--       },
--     },
--   },
-- })

-- require("typescript-tools").setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     tsserver_file_preferences = {
--       disableSuggestions = true,
--     },
--   },
-- })

-- lspconfig.purescriptls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     purescript = {
--       addSpagoSources = true,
--       censorWarnings = {
--         "ImplicitImport",
--         "UnusedExplicitImport",
--         "UnusedImport",
--       },
--       formatter = "purs-tidy",
--     },
--   },
--   flags = {
--     debounce_text_changes = 150,
--   },
-- })

-- lspconfig.rust_analyzer.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   handlers = {
--     ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--       underline = false,
--       virtual_text = true,
--     }),
--   },
--   settings = {
--     ["rust-analyzer"] = {
--       check = {
--         ignore = { "dead_code", "unused_imports", "unused_variables" },
--       },
--     },
--   },
-- })

-- local on_attach = function(client, bufnr)
--   -- client.server_capabilities.semanticTokensProvider = nil
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = "LSP: " .. desc
--     end
--
--     vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   local imap = function(keys, func, desc)
--     if desc then
--       desc = "LSP: " .. desc
--     end
--
--     vim.keymap.set("i", keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap("K", vim.lsp.buf.hover, "Hover Documentation")
--   nmap("gn", vim.lsp.buf.rename, "Rename Symbol")
--   nmap("ga", vim.lsp.buf.code_action, "Code Action")
--   nmap("gd", vim.lsp.buf.definition, "Goto Definition")
--   nmap("gD", vim.lsp.buf.implementation, "Goto Implementation")
--   nmap("gr", require("telescope.builtin").lsp_references, "References")
--   nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
--   nmap("<leader>dw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
--   imap("<C-x>", vim.lsp.buf.signature_help, "Signature Documentation")
--   nmap("<leader>cr", vim.lsp.codelens.refresh, "Refresh Code Lens")
--   nmap("<leader>ca", vim.lsp.codelens.run, "Run Code Lens")
--   nmap("<leader>cd", vim.lsp.codelens.display, "Display Code Lens")
-- end
