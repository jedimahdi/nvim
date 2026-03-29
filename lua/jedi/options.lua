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
  cmdheight = 1,
  showmode = true,
  showcmd = false,
  -- messagesopt = "wait:200,history:500", -- default = "hit-enter,history:500"
  report = 10000,

  signcolumn = "no",
  number = false,
  relativenumber = false,

  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  breakindent = true,

  wrap = false,
  smoothscroll = false, -- TODO: trying false for now
  cursorline = false, --highlight line
  scrolloff = 8,

  hlsearch = true,
  incsearch = true,
  inccommand = "nosplit",
  ignorecase = true,
  smartcase = true,

  swapfile = false,
  backup = false,
  undofile = true,

  foldmethod = "manual",
  foldenable = false,

  errorbells = false,
  belloff = "all",
  mouse = "nvi", --enable mouse
  clipboard = "unnamedplus", --system clipboard integration
  history = 100, --command line history
  guicursor = "",
  splitright = true,
  splitbelow = true,
  -- conceallevel = 2, --markdown conceal
  -- concealcursor = "nc",
  updatetime = 250, -- Save swap file and trigger CursorHold
  updatecount = 0,
  timeoutlen = 500,
  termguicolors = true,
  background = "dark",
  backspace = "indent,eol,start",
  wildmode = "longest:full,full",
  wildoptions = "pum",
  pumheight = 10,
  confirm = true,
  fillchars = { eob = " " },
  completeopt = { "menu", "menuone", "noinsert", "noselect" },
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end

vim.opt.shortmess:append({
  A = true,
  c = true,
  C = true,
  I = true,
  s = true,
  W = true,
})
