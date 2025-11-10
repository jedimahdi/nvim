vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
-- vim.g.loaded_gzip = 1

vim.g.c_syntax_for_h = 1
vim.g.have_nerd_font = true
vim.g.mapleader = " "

vim.opt.mouse = "a"
vim.opt.guicursor = ""
vim.opt.breakindent = true
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.errorbells = false
vim.opt.wrap = true
vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.laststatus = 0
vim.opt.ruler = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.conceallevel = 2

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = false

vim.opt.inccommand = "nosplit"
vim.opt.updatetime = 250
vim.opt.shortmess:append("c")
-- vim.opt.isfname:append("@-@")
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.timeoutlen = 500
