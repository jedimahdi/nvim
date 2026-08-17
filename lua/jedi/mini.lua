local M = {}

M.setup = function()
  require("mini.ai").setup()
  require("mini.surround").setup()
  require("mini.align").setup()
  require("mini.pairs").setup()
  require("mini.comment").setup()
end

return M
