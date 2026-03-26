local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "bash", "vimdoc", "query", "regex" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = false,
    },
  })
end

return M
