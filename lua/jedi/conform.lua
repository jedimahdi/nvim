local M = {}

M.opts = {
  formatters_by_ft = {
    c = { "clang-format" },
    glsl = { "clang-format" },
    lua = { "stylua" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    rust = { "rustfmt", lsp_format = "fallback" },
    go = { "goimports", "gofmt" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "jq" },
    markdown = { "prettier" },
    zig = { "zigfmt" },
    odin = { "odinfmt" },
  },
}

M.keys = {
  {
    "<leader>p",
    function() require("conform").format({}) end,
    desc = "Format file (Conform)",
  },
}

return M
