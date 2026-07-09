local M = {}

function M.setup()
  local langauges = {
    "bash",
    "sh",
    "c",
    "cpp",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "typescript",
    "vimdoc",
    "yaml",
    "nix",
    "toml",
    "zsh",
    "zig",
    "odin",
    "c3",
  }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = langauges,
    callback = function(args)
      vim.treesitter.start(args.buf)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
