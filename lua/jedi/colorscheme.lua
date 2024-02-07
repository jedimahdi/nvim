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

-- set sign
-- vim.cmd("sign define DiagnosticSignError text=  linehl= texthl=DiagnosticSignError numhl=")
-- vim.cmd("sign define DiagnosticSignHint text=  linehl= texthl=DiagnosticSignHint numhl=")
-- vim.cmd("sign define DiagnosticSignInfo text=  linehl= texthl=DiagnosticSignInfo numhl=")
-- vim.cmd("sign define DiagnosticSignWarn text=  linehl= texthl=DiagnosticSignWarn numhl=")

-- vim.cmd("colorscheme onedarker")

-- require("rose-pine").setup({
--   disable_background = true,
-- })
--
-- vim.cmd("colorscheme rose-pine")
--
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
