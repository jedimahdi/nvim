local M = {}

function M.setup()
  require("nvim-treesitter").setup({
    -- ensure_installed = { "c", "lua", "bash", "vimdoc", "query", "regex" },
    -- highlight = {
    --   enable = true,
    --   additional_vim_regex_highlighting = false,
    -- },
    -- indent = {
    --   enable = true,
    -- },
  })
end

return M
