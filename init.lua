require("jedi.set")
require("jedi.lazy")
require("jedi.mappings")
require("jedi.lsp")
require("jedi.colorscheme")
require("jedi.cmp")
require("jedi.tmux")
require("jedi.fzf")

local yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})
