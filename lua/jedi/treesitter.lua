local M = {}

local function treesitter_try_attach(buf, language)
  if not vim.treesitter.language.add(language) then
    return
  end
  vim.treesitter.start(buf, language)
  local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

  if has_indent_query then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

function M.setup()
  local parsers = {
    "bash",
    "c",
    "diff",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "query",
    "vim",
    "vimdoc",
    "json",
    "make",
    "toml",
    "zsh",
  }

  require("nvim-treesitter").install(parsers)

  local available_parsers = require("nvim-treesitter").get_available()
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local buf, filetype = args.buf, args.match
      local language = vim.treesitter.language.get_lang(filetype)

      if not language then
        return
      end

      local installed_parsers = require("nvim-treesitter").get_installed("parsers")

      if vim.tbl_contains(installed_parsers, language) then
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        require("nvim-treesitter")
          .install(language)
          :await(function() treesitter_try_attach(buf, language) end)
      end
    end,
  })
end

return M
