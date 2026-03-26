local M = {}

function M.setup()
  require("bqf").setup({
    auto_enable = true,
    auto_resize_height = true,
    preview = {
      winblend = 0, -- no transparency
      wrap = true,
      syntax = true, -- ensure syntax highlighting is enabled
    },
  })
end

return M
