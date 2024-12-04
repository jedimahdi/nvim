local dap = require("dap")
local dapui = require("dapui")

-- require("nvim-dap-virtual-text").setup()
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set("n", "<leader>lu", function()
  local widgets = require("dap.ui.widgets")
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.toggle()
end, { desc = "Toggle Debug UI" })
-- vim.keymap.set("n", "<leader>lb", "<cmd>DapToggleBreakpoint<CR>", { desc = "BreakPoint" })
vim.keymap.set("n", "<leader>ls", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<leader>ln", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<leader>lo", "<cmd>DapStepOver<CR>", { desc = "Step Out" })
vim.keymap.set("n", "<leader>li", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
vim.keymap.set("n", "<leader>lc", "<cmd>DapContinue<CR>", { desc = "Continue" })

vim.keymap.set("n", "<leader>lb", "<cmd>DapToggleBreakpoint<CR>", { desc = "Debug Breakpoint" })
vim.keymap.set("n", "<leader>lr", "<cmd>DapContinue<CR>", { desc = "Run Breakpoint" })

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    pid = function()
      local name = vim.fn.input("Executable name (filter): ")
      return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = "${workspaceFolder}",
  },
  {
    name = "Attach to gdbserver :1234",
    type = "gdb",
    request = "attach",
    target = "localhost:1234",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
  },
}
