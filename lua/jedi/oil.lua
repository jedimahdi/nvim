local M = {}

M.keys = {
  { "<leader>e", "<cmd>Oil<CR>", desc = "Open parent directory" },
}

M.opts = {
  default_file_explorer = true,
  view_options = {
    show_hidden = false,
    is_hidden_file = function(name, _)
      local folder_skip = { "dev-tools.locks", "dune.lock", "_build", "..", ".git" }
      return vim.tbl_contains(folder_skip, name)
    end,
  },
  use_default_keymaps = false,
  keymaps = {
    ["q"] = "actions.close",
    ["h"] = "actions.parent",
    ["l"] = "actions.select",
    ["<CR>"] = "actions.select",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["g."] = "actions.toggle_hidden",
  },
}

return M
