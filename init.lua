require("jedi.set")
require("jedi.lazy")
require("jedi.mappings")
require("jedi.lsp")
require("jedi.lsp.handlers")
require("jedi.lsp.diagnostic")
require("jedi.telescope")
require("jedi.colorscheme")
require("jedi.treesitter")
require("jedi.cmp")
require("jedi.harpoon")
require("jedi.tmux")
require("jedi.null")
require("jedi.dap")
require("jedi.oil")

require("Comment").setup()
require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt" },
})
require("nvim-ts-autotag").setup()

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})

vim.g.c_syntax_for_h = 1
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
