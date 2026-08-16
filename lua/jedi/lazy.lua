local spec = {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    lazy = false,
    config = require("jedi.colorscheme").onedarker,
  },
  {
    "neovim/nvim-lspconfig",
    ft = require("jedi.lsp").filetypes(),
    config = require("jedi.lsp").setup,
  },
  {
    "stevearc/oil.nvim",
    opts = require("jedi.oil").opts,
    keys = require("jedi.oil").keys,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    keys = {
      { "ys", mode = "n" },
      { "ds", mode = "n" },
      { "cs", mode = "n" },
      { "S", mode = "v" },
    },
    opts = {},
  },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    config = require("jedi.treesitter").setup,
    build = ":TSUpdate",
    lazy = false,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },
      sources = {
        providers = {
          buffer = {
            min_keyword_length = 4,
          },
        },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        documentation = { auto_show = true },
      },
      appearance = {
        nerd_font_variant = "normal",
      },
    },
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   config = require("jedi.cmp").setup,
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-cmdline",
  --   },
  -- },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    config = require("jedi.dap").setup,
    keys = require("jedi.dap").keys,
  },
  {
    "stevearc/conform.nvim",
    opts = require("jedi.conform").opts,
    keys = require("jedi.conform").keys,
  },
  {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
    opts = require("jedi.fzf").opts,
    keys = require("jedi.fzf").keys,
  },
  { "kevinhwang91/nvim-bqf", ft = "qf", config = require("jedi.bqf").setup },
  {
    "selimacerbas/markdown-preview.nvim",
    dependencies = { "selimacerbas/live-server.nvim" },
    cmd = { "MarkdownPreview" },
    config = function()
      require("markdown_preview").setup({
        instance_mode = "takeover",
        port = 0,
        open_browser = true,
        default_theme = "dark",
        debounce_ms = 300,
      })
    end,
  },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out =
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = spec,
  rocks = {
    enabled = false,
  },
  git = {
    throttle = {
      enabled = true,
      rate = 1,
      duration = 100,
    },
  },
})
