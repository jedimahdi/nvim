vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
-- vim.g.loaded_python3_provider = 0

vim.g.c_syntax_for_h = 1
vim.g.have_nerd_font = true
vim.g.mapleader = " "

vim.opt.laststatus = 0
vim.opt.ruler = false
vim.opt.cmdheight = 1
vim.opt.showmode = true
vim.opt.showcmd = true
-- vim.opt.messagesopt = "wait:200,history:500" -- default = "hit-enter,history:500"
-- vim.opt.report = 10000

vim.opt.signcolumn = "no"
vim.opt.number = false
vim.opt.relativenumber = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.concealcursor = "nc"

vim.opt.wrap = false
vim.opt.smoothscroll = true
vim.opt.cursorline = false
vim.opt.scrolloff = 5

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = "nosplit"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.foldmethod = "manual"
vim.opt.foldenable = false

vim.opt.errorbells = false
vim.opt.belloff = "all"
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.history = 1000
vim.opt.guicursor = ""
vim.opt.splitright = true
vim.opt.splitbelow = true
-- vim.opt.updatetime = 250 -- Save swap file and trigger CursorHold
vim.opt.updatecount = 0
vim.opt.timeoutlen = 500
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.backspace = "indent,eol,start"
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum"
vim.opt.pumheight = 10
vim.opt.confirm = true
vim.opt.fillchars = { eob = " " }
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

vim.opt.jumpoptions = "view"

vim.opt.shortmess:append("AcCIsW")
