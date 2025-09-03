local dap = require("dap")
local dapui = require("dapui")

require("nvim-dap-virtual-text").setup()

dapui.setup({
  layouts = {
    {
      elements = {
        {
          id = "scopes",
          size = 1,
        },
      },
      position = "left",
      size = 60,
    },
    {
      elements = {
        {
          id = "stacks",
          size = 0.70,
        },
        {
          id = "watches",
          size = 0.30,
        },
      },
      position = "bottom",
      size = 5,
    },
  },
  -- mappings = {
  --   edit = "e",
  --   expand = { "<CR>", "<2-LeftMouse>" },
  --   open = "o",
  --   remove = "d",
  --   repl = "r",
  --   toggle = "t",
  -- },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
--
-- vim.keymap.set("n", "<leader>lu", function()
--   local widgets = require("dap.ui.widgets")
--   local sidebar = widgets.sidebar(widgets.scopes)
--   sidebar.toggle()
-- end, { desc = "Toggle Debug UI" })
-- vim.keymap.set("n", "<leader>ls", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
-- vim.keymap.set("n", "<leader>ln", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
-- vim.keymap.set("n", "<leader>lo", "<cmd>DapStepOver<CR>", { desc = "Step Out" })
-- vim.keymap.set("n", "<leader>li", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
-- vim.keymap.set("n", "<leader>lc", "<cmd>DapContinue<CR>", { desc = "Continue" })
--
-- vim.keymap.set("n", "<leader>lb", "<cmd>DapToggleBreakpoint<CR>", { desc = "Debug Breakpoint" })
-- vim.keymap.set("n", "<leader>lB", "<cmd>DapClearBreakpoints<CR>", { desc = "Clear Debug Breakpoints" })
-- vim.keymap.set(
--   "n",
--   "<leader>la",
--   "<cmd>DapTerminate<CR> <BAR> <cmd>DapClearBreakpoints<CR>",
--   { desc = "Terminate and Clear Breakpoints", silent = true }
-- )
-- vim.keymap.set("n", "<leader>lr", "<cmd>DapContinue<CR>", { desc = "Run Breakpoint" })
-- vim.keymap.set("n", "<leader>ls", "<cmd>DapTerminate<CR>", { desc = "Terminate Debugger" })

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--quiet", "--interpreter=dap", "--eval-command", "set print pretty on" },
}

-- Function to find the executable or source file
local function get_program()
  local cwd = vim.fn.getcwd()
  -- Common executable names
  local possible_executables = { "a.out", "main", "program" } -- Add more as needed
  for _, exec in ipairs(possible_executables) do
    local path = cwd .. "/" .. exec
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end

  -- Fallback: Look for a source file with "main" function
  -- local files = vim.fn.glob(cwd .. "/*.{c,cpp}", true, true)
  -- for _, file in ipairs(files) do
  --   local content = table.concat(vim.fn.readfile(file), "\n")
  --   if content:match("main%s*%(") then
  --     -- Assume the executable name matches the source file (without extension)
  --     local exec_name = vim.fn.fnamemodify(file, ":t:r")
  --     local exec_path = cwd .. "/" .. exec_name
  --     if vim.fn.filereadable(exec_path) == 1 then
  --       return exec_path
  --     else
  --       -- If no executable exists, return the source file and warn user
  --       vim.notify("No compiled executable found for " .. file .. ". Compile it first.", vim.log.levels.WARN)
  --       return file
  --     end
  --   end
  -- end

  -- Final fallback: Prompt user if nothing is found
  return vim.fn.input("Path to executable: ", cwd .. "/", "file")
end

dap.configurations.asm = {
  {
    name = "Launch NASM",
    type = "gdb",
    request = "launch",
    program = get_program,
    cwd = "${workspaceFolder}",
    stopAtEntry = true, -- Stop at program entry point (e.g., _start)
  },
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    -- program = function()
    --   return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    -- end,
    program = get_program,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    -- stopAtBeginningOfMainSubprogram = false,
  },
}
