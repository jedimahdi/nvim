local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
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

local dap_spec = require("jedi.dap")
local oil_spec = require("jedi.oil")
local conform_spec = require("jedi.conform")
local fzf_spec = require("jedi.fzf")

local spec = {
  { "navarasu/onedark.nvim" },
  "neovim/nvim-lspconfig",
  {
    "stevearc/oil.nvim",
    opts = oil_spec.opts,
    keys = oil_spec.keys,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "kylechui/nvim-surround", version = "^3.0.0", event = "VeryLazy", opts = {} },
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
  { "windwp/nvim-autopairs", event = "VeryLazy", opts = {} },
  { "nvim-treesitter/nvim-treesitter", config = require("jedi.treesitter").setup },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    config = dap_spec.setup,
    keys = dap_spec.keys,
  },
  { "stevearc/conform.nvim", opts = conform_spec.opts, keys = conform_spec.keys },
  { "ibhagwan/fzf-lua", cmd = { "FzfLua" }, opts = fzf_spec.opts, keys = fzf_spec.keys },
  { "kevinhwang91/nvim-bqf", ft = "qf", config = require("jedi.bqf").setup },
}

require("lazy").setup({
  spec = spec,
  rocks = {
    enabled = false,
  },
})
