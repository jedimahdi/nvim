local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

telescope.setup({
  defaults = {
    winblend = 0,
    layout_config = {
      width = 0.95,
      height = 0.95,
      prompt_position = "bottom",
    },
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

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>F", builtin.git_files, { desc = "Search Git Files" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>x", builtin.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope Git Branches" })
vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find({
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer]" })
