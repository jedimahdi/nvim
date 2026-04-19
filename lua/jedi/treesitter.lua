local M = {}

function M.setup()
  local langauges = {
    "bash",
    "c",
    "cpp",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "typescript",
    "vimdoc",
    "yaml",
  }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = langauges,
    callback = function(args) vim.treesitter.start(args.buf) end,
  })
end

return M
