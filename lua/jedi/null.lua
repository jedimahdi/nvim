local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.clang_format,
  -- null_ls.builtins.diagnostics.clang_check,
  null_ls.builtins.formatting.shfmt,
  -- null_ls.builtins.diagnostics.shellcheck,
  -- null_ls.builtins.code_actions.shellcheck,
  -- require("jedi.null.cabal-fmt"),
  -- require("jedi.null.fourmolu"),
  -- require("jedi.null.rustfmt"),
  -- null_ls.builtins.formatting.ocamlformat,
  null_ls.builtins.formatting.gofmt,
}

null_ls.setup({
  sources = sources,
  diagnostic_config = {
    underline = false,
  },
})
