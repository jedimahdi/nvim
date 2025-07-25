vim.opt.termguicolors = true
vim.opt.background = "dark"

require("onedark").setup({
  style = "darker",
})
require("onedark").load()

local transparent = {
  bg = "none",
  ctermbg = "none",
}

vim.api.nvim_set_hl(0, "Normal", transparent)
vim.api.nvim_set_hl(0, "NonText", transparent)
vim.api.nvim_set_hl(0, "SignColumn", transparent)
vim.api.nvim_set_hl(0, "Search", {
  bg = "#292e36",
})
vim.api.nvim_set_hl(0, "CurSearch", {
  bg = "#30353d",
})
vim.api.nvim_set_hl(0, "IncSearch", {
  bg = "#363d47",
})
vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })
