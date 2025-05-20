local api = vim.api

local send_tmux_cmd = function(cmd)
  local stdout = vim.split(vim.fn.system("tmux " .. cmd), "\n", {})
  return stdout, vim.v.shell_error
end

local get_pane_id = function()
  return send_tmux_cmd('display-message -p "#{pane_id}"')[1]
end

-- move between tmux splits and neovim windows
local tmux_directions = { h = "L", j = "D", k = "U", l = "R" }

local send_move_cmd = function(direction)
  send_tmux_cmd("selectp -" .. tmux_directions[direction])
end

local move = function(direction)
  local current_win = api.nvim_get_current_win()
  vim.cmd("wincmd " .. direction)

  if api.nvim_get_current_win() == current_win then
    send_move_cmd(direction)
  end
end

local initial_tmux_pane = function() end

local run_project = function()
  -- local ft = vim.bo.ft

  -- if ft == "typescriptreact" or ft == "typescript" then
  --   send_tmux_cmd("neww -dn npm npm run dev")
  -- end
end

-- u.nmap("<leader>tq", ":lua require'config.tmux'.run_project()<CR>")

local exec_project = function()
  local ft = vim.bo.ft
  if ft == "rust" then
    send_tmux_cmd([[neww -n cargo bash -c "cargo run -q; sleep 2"]])
  end
  if ft == "go" then
    send_tmux_cmd([[neww -n go bash -c "go run .; sleep 2"]])
  end
  if ft == "haskell" then
    send_tmux_cmd([[neww -n cabal bash -c "cabal run -v0"]])
  end
end

local test_project = function()
  local ft = vim.bo.ft
  if ft == "typescript" then
    send_tmux_cmd([[split-window -h -p 30 -d bash -c "npx jest --watch"]])
  end

  if ft == "rust" then
    send_tmux_cmd([[neww -n cargo bash -c "cargo test; sleep 2"]])
  end

  if ft == "haskell" then
    send_tmux_cmd([[neww -n cabal bash -c "cabal test --test-show-details=always --test-option="--color" ; sleep 2"]])
  end
end

local build_project = function()
  local ft = vim.bo.ft
  if ft == "rust" then
    send_tmux_cmd([[neww -n cargo bash -c "cargo build; sleep 2"]])
  end

  if ft == "haskell" then
    send_tmux_cmd([[neww -dn cabal-build bash -c "cabal build"]])
  end
end

vim.keymap.set("n", "<C-h>", function()
  move("h")
end)
vim.keymap.set("n", "<C-j>", function()
  move("j")
end)
vim.keymap.set("n", "<C-k>", function()
  move("k")
end)
vim.keymap.set("n", "<C-l>", function()
  move("l")
end)

local run_command = function()
  vim.ui.input({
    prompt = "Command: ",
    completion = "shellcmd",
  }, function(command)
    if command ~= nil then
      send_tmux_cmd([[neww -n cargo bash -c "]] .. command .. [["]])
    end
  end)

  -- vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  -- local ft = vim.bo.ft
  -- if ft == "rust" then
  --   send_tmux_cmd([[neww -n cargo bash -c "cargo run -q; sleep 2"]])
  -- end
  -- if ft == "go" then
  --   send_tmux_cmd([[neww -n go bash -c "go run .; sleep 2"]])
  -- end
  -- if ft == "haskell" then
  --   send_tmux_cmd([[neww -n cabal bash -c "cabal run -v0"]])
  -- end
end

local function build_project()
  -- Create a new split window for the terminal
  -- vim.cmd("split")
  -- -- Start the build process (you can replace 'make' with your own build command)
  -- local job_id = vim.fn.jobstart('make', {
  --   on_stdout = function(_, data)
  --     if data then
  --       -- If successful, close the window immediately
  --       vim.cmd("close")
  --     end
  --   end,
  --   on_exit = function(_, exit_code)
  --     -- if exit_code ~= 0 then
  --     --   -- If failed, wait for 2 seconds and then close the window
  --     --   vim.defer_fn(function()
  --     --     vim.cmd("close")
  --     --   end, 2000)
  --     -- end
  --   end,
  -- })
  local pane_id = vim.fn.system("tmux split-window -P -F '#{pane_id}' -dh -p 30") -- Open a vertical tmux pane
  pane_id = pane_id:gsub("\n", "") -- Remove newlines from the output

  local command = "make; if [ $? -eq 0 ]; then tmux kill-pane -t "
    .. pane_id
    .. "; else sleep 2; tmux kill-pane -t "
    .. pane_id
    .. "; fi"
  vim.fn.system("tmux send-keys -t " .. pane_id .. " '" .. command .. "' Enter")
end

vim.keymap.set("n", "<leader>tr", build_project, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>tt", run_command)
-- vim.keymap.set("n", "<leader>tt", test_project)
-- u.nmap("<leader>te", ":lua require'config.tmux'.exec_project()<CR>")
-- u.nmap("<leader>tt", ":lua require'config.tmux'.test_project()<CR>")
-- u.nmap("<leader>tb", ":lua require'config.tmux'.build_project()<CR>")
