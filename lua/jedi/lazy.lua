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

vim.o.termguicolors = true

require("lazy").setup({
  "navarasu/onedark.nvim",
  -- "folke/tokyonight.nvim",
  "neovim/nvim-lspconfig",
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, _)
          local folder_skip = { "dev-tools.locks", "dune.lock", "_build", "..", ".git" }
          return vim.tbl_contains(folder_skip, name)
        end,
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["h"] = "actions.parent",
        ["l"] = "actions.select",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    },
    lazy = false,
    keys = {
      { "<leader>e", "<cmd>Oil<CR>", desc = "Open parent directory" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      local harpoon = require("harpoon")
      vim.keymap.set("n", "<leader>sa", function()
        harpoon:list():add()
      end, { desc = "Harpoon add file" })
      vim.keymap.set("n", "<leader>ss", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon quick menu" })

      for i = 1, 5 do
        vim.keymap.set("n", string.format("<leader>%s", i), function()
          harpoon:list():select(i)
        end, { desc = "Harpoon uuquick menu" })
      end
    end,
  },
  { "numToStr/Comment.nvim", opts = {} },
  { "windwp/nvim-autopairs", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "bash" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    event = "VeryLazy",
    config = function()
      require("jedi.dap")
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        glsl = { "clang_format" },
        lua = { "stylua" },
        sh = { "shfmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
        go = { "goimports", "gofmt" },
        javascript = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
  },
})
