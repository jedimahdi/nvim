local dap_spec = require("jedi.dap")
local oil_spec = require("jedi.oil")
local conform_spec = require("jedi.conform")
local fzf_spec = require("jedi.fzf")

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
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = require("jedi.lsp").setup,
  },
  {
    "stevearc/oil.nvim",
    opts = oil_spec.opts,
    keys = oil_spec.keys,
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
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = require("jedi.cmp").setup,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    config = dap_spec.setup,
    keys = dap_spec.keys,
  },
  { "stevearc/conform.nvim", opts = conform_spec.opts, keys = conform_spec.keys },
  { "ibhagwan/fzf-lua", cmd = { "FzfLua" }, opts = fzf_spec.opts, keys = fzf_spec.keys },
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
})
