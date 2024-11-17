local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

telescope.setup({
  defaults = {
    winblend = 0,
    border = false,
    layout_config = {
      preview_cutoff = 1,
      width = 0.99,
      height = 0.99,
    },
    sorting_strategy = "descending",
    prompt_position = "bottom",
    selection_strategy = "reset",
    scroll_strategy = "cycle",
    color_devicons = true,
    -- file_ignore_patterns = {
    --   "dist*",
    --   "node_modules",
    --   "output",
    --   "target",
    --   -- "\\.git",
    --   "dist/",
    --   [[elm.stuff]],
    --   "flake.lock",
    --   "package-lock.json",
    --   "Cargo.lock",
    -- },

    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Esc>"] = actions.close,
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,
        ["<M-p>"] = action_layout.toggle_preview,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Esc>"] = actions.close,
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,
      },
    },

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})

require("telescope").load_extension("fzf")

vim.keymap.set("n", "<leader>f", function()
  builtin.find_files({
    find_command = {
      "rg",
      "--files",
      "--hidden",
      "-g",
      "!node_modules/",
      "-g",
      "!.git/",
      "-g",
      "!target/",
      "-g",
      "!Cargo.lock",
      "-g",
      "!package-lock.json",
    },
  })
end, { desc = "Telescope Find Files" })
vim.keymap.set("n", "<leader>F", function()
  builtin.find_files({ search_dirs = { vim.fn.expand("%:p:h") } })
end, { desc = "Telescope Search Files Current Directory" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope Live Grep" })
vim.keymap.set("n", "<leader>G", function()
  builtin.live_grep({ search_dirs = { vim.fn.expand("%:p:h") } })
end, { desc = "Telescope Live Grep Current Directory" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Telescope Live Grep" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Telescope Grep String" })
vim.keymap.set("n", "<leader>sf", builtin.git_files, { desc = "Telescope Search Git Files" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope Buffers" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Telescope Diagnostics" })
vim.keymap.set("n", "<leader>x", builtin.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>sb", builtin.git_branches, { desc = "Telescope Git Branches" })
vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find({
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer]" })
