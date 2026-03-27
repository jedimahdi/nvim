local send_tmux_cmd = function(cmd)
  local stdout = vim.split(vim.fn.system("tmux " .. cmd), "\n", {})
  return stdout, vim.v.shell_error
end

local tmux_directions = { h = "L", j = "D", k = "U", l = "R" }

local move = function(direction)
  return function()
    local current_win = vim.api.nvim_get_current_win()
    vim.cmd("wincmd " .. direction)

    if vim.api.nvim_get_current_win() == current_win then
      send_tmux_cmd("selectp -" .. tmux_directions[direction])
    end
  end
end

vim.keymap.set("n", "<C-h>", move("h"))
vim.keymap.set("n", "<C-j>", move("j"))
vim.keymap.set("n", "<C-k>", move("k"))
vim.keymap.set("n", "<C-l>", move("l"))
