local M = {}

M.opts = {
  { "default" },
  fzf_opts = {
    -- ["--tmux"] = "90%",
    ["--border"] = "rounded",
  },
  defaults = { git_icons = false, file_icons = false },
  files = {
    fzf_opts = {
      ["--ansi"] = false,
      ["--scheme"] = "path",
    },
  },
  winopts = {
    preview = { default = "bat" },
    treesitter = false,
    width = 0.9,
    height = 0.9,
    border = { "", "", "", "", "", "", "", "" },
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
  {
    "<leader>f",
    function() require("fzf-lua").files() end,
    desc = "Find Files",
    mode = "n",
    silent = true,
  },
  {
    "<leader>b",
    function() require("fzf-lua").buffers() end,
    desc = "Buffers",
    mode = "n",
  },
  {
    "<leader>g",
    function() require("fzf-lua").live_grep() end,
    desc = "Live Grep",
    mode = "n",
  },
  {
    "<leader>sg",
    function() require("fzf-lua").grep() end,
    desc = "Grep",
    mode = "n",
  },
  {
    "<leader>sw",
    function() require("fzf-lua").grep_cword() end,
    desc = "Grep word",
    mode = "n",
  },
  {
    "<leader>sW",
    function() require("fzf-lua").grep_cWORD() end,
    desc = "Grep WORD",
    mode = "n",
  },
  {
    "<leader>sw",
    function() require("fzf-lua").grep_visual() end,
    desc = "Grep visual",
    mode = "v",
  },
  {
    "<leader>st",
    function() require("fzf-lua").tags_live_grep() end,
    desc = "Tags live grep",
    mode = "n",
  },
  {
    "<leader>sh",
    function() require("fzf-lua").helptags() end,
    desc = "Helps",
    mode = "n",
  },
  {
    "<leader>sm",
    function() require("fzf-lua").manpages() end,
    desc = "Man Pages",
    mode = "n",
  },
  {
    "<leader>sd",
    function() require("fzf-lua").diagnostics_document() end,
    desc = "Diagnostics document",
    mode = "n",
  },
  {
    "<leader>sk",
    function() require("fzf-lua").keymaps() end,
    desc = "Keymaps",
    mode = "n",
  },
}

return M
