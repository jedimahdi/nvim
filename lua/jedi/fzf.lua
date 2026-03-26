local M = {}

M.opts = {
  { "default-title" },
  fzf_opts = {
    ["--tmux"] = "90%",
    ["--border"] = "rounded",
  },
  defaults = { git_icons = false, file_icons = false },
  files = { fzf_opts = { ["--ansi"] = false } },
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
}

M.keys = {
  { "<leader>f", "<cmd>FzfLua files<CR>", desc = "Find Files", mode = "n" },
  { "<leader>b", "<cmd>FzfLua buffers<CR>", desc = "Buffers", mode = "n" },
  { "<leader>g", "<cmd>FzfLua buffers<CR>", desc = "Buffers", mode = "n" },
  { "<leader>g", "<cmd>FzfLua live_grep<CR>", desc = "Live Grep", mode = "n" },
  { "<leader>sg", "<cmd>FzfLua grep<CR>", desc = "Grep", mode = "n" },
  { "<leader>sw", "<cmd>FzfLua grep_cword<CR>", desc = "Grep word", mode = "n" },
  { "<leader>sW", "<cmd>FzfLua grep_cWORD<CR>", desc = "Grep WORD", mode = "n" },
  { "<leader>sw", "<cmd>FzfLua grep_visual<CR>", desc = "Grep visual", mode = "n" },
  { "<leader>st", "<cmd>FzfLua tags_live_grep<CR>", desc = "Tags live grep", mode = "n" },
  { "<leader>sh", "<cmd>FzfLua helptags<CR>", desc = "Helps", mode = "n" },
  { "<leader>sm", "<cmd>FzfLua manpages<CR>", desc = "Man Pages", mode = "n" },
  { "<leader>sd", "<cmd>FzfLua diagnostics_document<CR>", desc = "Diagnostics document", mode = "n" },
  { "<leader>sk", "<cmd>FzfLua keymaps<CR>", desc = "Keymaps", mode = "n" },
}

return M

-- vim.keymap.set("n", "<leader>f", fzf.files, { desc = "Find Files" })
-- vim.keymap.set("n", "<leader>b", fzf.buffers, { desc = "Buffers" })
-- vim.keymap.set("n", "<leader>g", fzf.live_grep, { desc = "Live Grep" })
-- vim.keymap.set("n", "<leader>sg", fzf.grep, { desc = "Grep" })
-- vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "Grep word" })
-- vim.keymap.set("n", "<leader>sW", fzf.grep_cWORD, { desc = "Grep WORD" })
-- vim.keymap.set("v", "<leader>sw", fzf.grep_visual, { desc = "Grep visual" })
-- vim.keymap.set("n", "<leader>st", fzf.tags_live_grep, { desc = "Tags live grep" })
-- vim.keymap.set("n", "<leader>sh", fzf.helptags, { desc = "Helps" })
-- vim.keymap.set("n", "<leader>sm", fzf.manpages, { desc = "Man Pages" })
-- vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, { desc = "Diagnostics document" })
-- vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "Keymaps" })
