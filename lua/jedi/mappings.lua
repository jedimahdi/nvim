vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function k(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false

  vim.keymap.set(mode, lhs, rhs, opts)
end

k({ "n", "x" }, "<Space>", "<Nop>")

k({ "n", "x" }, "c", '"_c')
k({ "n", "x" }, "C", '"_C')
k({ "n", "x" }, "x", '"_x')
k({ "n", "x" }, "X", '"_X')

k("i", "<C-a>", "<Home>")
k("i", "<C-e>", "<End>")
k("i", "<C-d>", "<Del>", { desc = "Delete the character to the right of the cursor" })

k("n", "u", "<cmd>silent undo<CR>")
k("n", "<C-r>", "<cmd>silent redo<CR>")

k("x", "K", ":m '<-2<CR>gv=gv")
k("x", "J", ":m '>+1<CR>gv=gv")
k("n", "J", "mzJ`z")

k("n", "n", "nzzzv")
k("n", "N", "Nzzzv")

k("x", "p", "P")
k("x", "<", "<gv")
k("x", ">", ">gv")

k("n", "[e", "g;", { desc = "Go to older position in change list." })
k("n", "]e", "g,", { desc = "Go to [count] newer position in change list" })
k("n", "]l", "<cmd>lnext<CR>zz")
k("n", "[l", "<cmd>lprev<CR>zz")
k("n", "]c", "<cmd>cnext<CR>zz")
k("n", "[c", "<cmd>cprev<CR>zz")

k("n", "<C-s>", [[:%s//<C-r>//g<Left><Left>]], { desc = ":s with last search pattern", silent = false })
k("n", "<leader>r", [[:%s/\V\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Replace word under cursor", silent = false })
k("x", "<leader>r", [["sy:<C-u>%s/\V<C-r>=escape(@s, '\\/')<CR>//gI<Left><Left><Left>]], { desc = "Replace selection", silent = false })

k("n", "<leader>w", function()
  vim.cmd.update()
  vim.defer_fn(function() vim.cmd("echo") end, 500)
end)
k("n", "<leader>n", function()
  vim.cmd.nohlsearch()
  vim.cmd("echo")
end)

k("n", "<leader>q", "<cmd>silent xit<CR>")

k("n", "<leader><leader>", function()
  local alt = vim.fn.bufnr("#")
  if alt ~= -1 then
    vim.api.nvim_set_current_buf(alt)
  end
  vim.cmd("echo")
end, { desc = "Last buffer" })

k("n", "<leader>z", "<cmd>InspectTree<CR>")

k("n", "<leader>i", function() vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0 end, { desc = "Toggle conceal" })

k("n", "<leader>x", function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Buffer is not a file", vim.log.levels.WARN)
    return
  end
  vim.system({ "chmod", "+x", path }, {}, function(res)
    vim.schedule(function()
      if res.code == 0 then
        vim.notify("chmod +x " .. vim.fn.fnamemodify(path, ":t"))
      else
        vim.notify((res.stderr or "chmod failed"):gsub("%s+$", ""), vim.log.levels.ERROR)
      end
    end)
  end)
end, { desc = "chmod +x current file" })

k("n", "<leader>u", function()
  if not package.loaded["undotree"] then
    vim.cmd("packadd nvim.undotree")
  end
  require("undotree").open({ command = "40vnew" })
end, { desc = "Open Undo Tree", silent = true })

local function wintmux(w, t)
  local win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. w)
  if vim.api.nvim_get_current_win() == win and vim.env.TMUX then
    vim.system({ "tmux", "select-pane", "-" .. t })
  end
end

k("n", "<C-h>", function() wintmux("h", "L") end)
k("n", "<C-j>", function() wintmux("j", "D") end)
k("n", "<C-k>", function() wintmux("k", "U") end)
k("n", "<C-l>", function() wintmux("l", "R") end)
