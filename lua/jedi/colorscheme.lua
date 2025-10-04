local function onedarker()
  require("onedark").setup({
    style = "darker",
  })
  require("onedark").load()

  local transparent = {
    bg = "none",
    ctermbg = "none",
  }

  vim.api.nvim_set_hl(0, "Normal", transparent)
  vim.api.nvim_set_hl(0, "NonText", transparent)
  vim.api.nvim_set_hl(0, "SignColumn", transparent)
  vim.api.nvim_set_hl(0, "Search", {
    bg = "#292e36",
  })
  vim.api.nvim_set_hl(0, "CurSearch", {
    bg = "#30353d",
  })
  vim.api.nvim_set_hl(0, "IncSearch", {
    bg = "#363d47",
  })
  vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })
end

local function kanagawa()
  require("kanagawa").setup({
    transparent = true, -- or false, depending on your taste
    overrides = function(colors)
      local theme = colors.theme
      return {
        SignColumn = { bg = "NONE" },
        LineNr = { bg = "NONE" },
        CursorLineNr = { bg = "NONE" },
        -- Completion menu background
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_dim },
        -- Selected item in completion menu
        PmenuSel = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
        -- Scrollbar
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },

        -- nvim-cmp specific groups
        CmpItemAbbr = { fg = theme.ui.fg },
        CmpItemAbbrMatch = { fg = theme.syn.keyword, bold = true },
        CmpItemAbbrMatchFuzzy = { fg = theme.syn.keyword, italic = true },
        CmpItemMenu = { fg = theme.ui.comment },
      }
    end,
  })
  vim.cmd("colorscheme kanagawa")
end

vim.opt.termguicolors = true
vim.opt.background = "dark"
onedarker()
