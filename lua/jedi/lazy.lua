local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Fixes Notify opacity issues
vim.o.termguicolors = true

require("lazy").setup({
  "folke/tokyonight.nvim",
  -- { "catppuccin/nvim", name = "catppuccin" },
  "nvimtools/none-ls.nvim",
  "tamago324/lir.nvim",
  "mbbill/undotree",
  "ThePrimeagen/harpoon",
  "onsails/lspkind-nvim",
  "navarasu/onedark.nvim",
  "numToStr/Comment.nvim",
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "tpope/vim-surround",
  "tpope/vim-abolish",
  "kyazdani42/nvim-web-devicons",
  -- "tjdevries/ocaml.nvim",
  "purescript-contrib/purescript-vim",
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  -- "theHamsta/nvim-dap-virtual-text",
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- { "norcalli/nvim-colorizer.lua" , config = function()
  --   require 'colorizer'.setup()
  -- end
  -- }
})
