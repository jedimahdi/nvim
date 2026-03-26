local root = vim.env.USER == "root"

local globals = {
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,
  loaded_netrwSettings = 1,
  loaded_ruby_provider = 0,
  loaded_perl_provider = 0,
  loaded_node_provider = 0,
  loaded_python3_provider = 0,
  -- loaded_gzip = 1,

  c_syntax_for_h = 1,
  have_nerd_font = true,
  editorconfig = true,

  mapleader = " ",
}

local options = {
  laststatus = 0,
  ruler = false,
  cmdheight = 0,
  showmode = false,
  showcmd = false,
  messagesopt = "wait:200,history:500", -- default = "hit-enter,history:500"

  signcolumn = "no",
  number = false,
  relativenumber = false,

  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  breakindent = true,

  wrap = true,
  smoothscroll = true,
  cursorline = false, --highlight line
  scrolloff = 8,
  ttyfast = true, --faster scrolling

  hlsearch = true,
  incsearch = true,
  inccommand = "nosplit",
  ignorecase = true,
  smartcase = true,

  swapfile = false,
  backup = false,
  undofile = true,

  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevel = 99, --disable folding, lower #s enable

  errorbells = false,
  belloff = "all",
  mouse = "nvi", --enable mouse
  clipboard = "unnamedplus", --system clipboard integration
  history = 100, --command line history
  guicursor = "",
  splitright = true,
  splitbelow = true,
  conceallevel = 2, --markdown conceal
  concealcursor = "nc",
  updatetime = 250, -- Save swap file and trigger CursorHold
  updatecount = 0,
  timeoutlen = 500,
  termguicolors = true,
  background = "dark",
  backspace = "indent,eol,start",
  encoding = "utf-8",
  shell = "sh", -- shell to use for `!`, `:!`, `system()` etc.
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end

vim.opt.shortmess:append({
  A = true, -- When a swap file is found.
  c = true, -- 'ins-completion-menu' messages.
  I = true, -- Skip intro message.
  s = true, -- Search hit BOTTOM/TOP messages.
})
