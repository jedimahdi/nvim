local dap = require("dap")
local M = {}

-- Utility: find executable in project root or build/
local function find_binary(callback)
  local cwd = vim.fn.getcwd()
  local search_dirs = { cwd, cwd .. "/build" }
  local executables = {}

  for _, dir in ipairs(search_dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      local files = vim.fn.readdir(dir, function(name)
        local path = dir .. "/" .. name
        return vim.fn.executable(path) == 1 and vim.fn.isdirectory(path) == 0
      end)
      for _, f in ipairs(files) do
        table.insert(executables, dir .. "/" .. f)
      end
    end
  end

  if #executables == 0 then
    -- fallback: ask user
    local bin = vim.fn.input("Path to executable: ", cwd .. "/", "file")
    callback(bin)
  elseif #executables == 1 then
    -- only one found
    callback(executables[1])
  else
    -- multiple: let user pick
    vim.ui.select(executables, { prompt = "Select executable:" }, function(choice)
      if choice then
        callback(choice)
      end
    end)
  end
end

local function ask_args()
  local args_str = vim.fn.input("Arguments: ")
  return vim.split(args_str, " +")
end

M.gdb_run_auto_noargs = function()
  find_binary(function(bin)
    dap.run({
      name = "Auto bin, no args",
      type = "gdb",
      request = "launch",
      program = bin,
      args = {},
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    })
  end)
end

M.gdb_run_auto_args = function()
  find_binary(function(bin)
    dap.run({
      name = "Auto bin, no args",
      type = "gdb",
      request = "launch",
      program = bin,
      args = ask_args,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    })
  end)
end

return M
