local M = {}

M.opts = {
  formatters_by_ft = {
    c = { "clang-format" },
    glsl = { "clang-format" },
    lua = { "stylua" },
    sh = { "shfmt" },
    rust = { "rustfmt", lsp_format = "fallback" },
    go = { "goimports", "gofmt" },
    javascript = { "prettier" },
    json = { "jq" },
    markdown = { "prettier" },
    zig = { "zigfmt" },
  },
}

M.keys = {
  {
    "<leader>p",
    function()
      require("conform").format({})
    end,
    desc = "Format file (Conform)",
  },
}

return M
