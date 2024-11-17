require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "lua",
    "rust",
    "haskell",
    "json",
    "javascript",
    "nix",
    "yaml",
    "typescript",
    "tsx",
    "toml",
    "markdown",
    "html",
    "go",
    "bash",
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  -- autotag = {
  --   enable = true,
  -- },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-Space>",
      node_incremental = "<C-Space>",
      scope_incremental = false,
      node_decremental = "<BS>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
      include_surrounding_whitespace = true,
    },
  },
})

-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
