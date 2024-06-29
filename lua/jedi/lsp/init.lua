local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  local imap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("i", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>gr", vim.lsp.buf.rename, "Rename Symbol")
  nmap("ga", vim.lsp.buf.code_action, "Code Action")
  nmap("gd", vim.lsp.buf.definition, "Goto Definition")
  nmap("<leader>di", vim.lsp.buf.implementation, "Goto Implementation")
  nmap("gr", require("telescope.builtin").lsp_references, "References")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
  nmap("<leader>dw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
  imap("<C-x>", vim.lsp.buf.signature_help, "Signature Documentation")
  nmap("<leader>cr", vim.lsp.codelens.refresh, "Refresh Code Lens")
  nmap("<leader>ca", vim.lsp.codelens.run, "Run Code Lens")
  nmap("<leader>cd", vim.lsp.codelens.display, "Display Code Lens")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.insertReplaceSupport = false
capabilities.textDocument.codeLens = { dynamicRegistration = false }
capabilities.offsetEncoding = { "utf-16" }

local servers = { "jsonls", "html", "bashls", "gopls", "ocamllsp", "zls", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

lspconfig.hls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.nil_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["nil"] = {
      nix = {
        -- maxMemoryMB = 7680,
        flake = {
          autoArchive = false,
          autoEvalInputs = false,
        },
      },
    },
  },
})

require("typescript-tools").setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    tsserver_file_preferences = {
      disableSuggestions = true,
    },
  },
})

lspconfig.purescriptls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    purescript = {
      addSpagoSources = true,
      censorWarnings = {
        "ImplicitImport",
        "UnusedExplicitImport",
        "UnusedImport",
      },
      formatter = "purs-tidy",
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
})

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = false,
      virtual_text = true,
    }),
  },
  settings = {
    ["rust-analyzer"] = {
      check = {
        ignore = { "dead_code", "unused_imports", "unused_variables" },
      },
    },
  },
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      },
    })
  end,
  settings = {
    Lua = {},
  },
})
