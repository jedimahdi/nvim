local fzf = require("fzf-lua")
fzf.setup({
  { "default-title" },
  desc = "fzf-native run inside a tmux popup",
  fzf_opts = {
    ["--tmux"] = "90%",
    ["--border"] = "rounded",
  },
  fzf_colors = {
    false,
  },
  defaults = { git_icons = false, file_icons = false },
  winopts = {
    width = 0.9,
    height = 0.9,
    border = { "", "", "", "", "", "", "", "" },
    preview = {
      hidden = true,
      border = { "", "", "", "", "", "", "", "" },
      winopts = {
        number = false,
        relativenumber = false,
      },
    },
  },
  lsp = { code_actions = { previewer = "codeaction_native" } },
  grep = {
    RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
  },
  -- tags = { previewer = "bat" },
  -- btags = { previewer = "bat" },
  lines = { _treesitter = false },
  blines = { _treesitter = false },
})

vim.keymap.set("n", "<leader>f", fzf.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>g", fzf.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>sg", fzf.grep, { desc = "Grep" })
vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "Grep word" })
vim.keymap.set("n", "<leader>sW", fzf.grep_cWORD, { desc = "Grep WORD" })
vim.keymap.set("v", "<leader>sw", fzf.grep_visual, { desc = "Grep visual" })
vim.keymap.set("n", "<leader>st", fzf.tags_live_grep, { desc = "Tags live grep" })
vim.keymap.set("n", "<leader>sh", fzf.helptags, { desc = "Helps" })
vim.keymap.set("n", "<leader>sm", fzf.manpages, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, { desc = "Diagnostics document" })
vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "Keymaps" })
