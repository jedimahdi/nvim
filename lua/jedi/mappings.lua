local function k(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.noremap = opts.noremap ~= false

  vim.keymap.set(mode, lhs, rhs, opts)
end

k({ "n", "v" }, "<Space>", "<Nop>")

k("n", "<C-S>", ":%s/", { silent = false })
k("v", "<C-S>", ":s/", { silent = false })

k({ "n", "x" }, "c", '"_c')
k("n", "cc", '"_cc')
k("n", "C", '"_C')

k({ "n", "x" }, "x", '"_x')
k("n", "X", '"_X')

k("i", "<C-A>", "<HOME>")
k("i", "<C-E>", "<END>")

k("c", "<C-A>", "<HOME>", { desc = "Go to beginning of command" })

k("i", "<C-D>", "<DEL>", { desc = "Delete the character to the right of the cursor" })

k("v", "K", ":m '<-2<CR>gv=gv")
k("v", "J", ":m '>+1<CR>gv=gv")

k("n", "Y", "yg$")
k("n", "n", "nzzzv")
k("n", "N", "Nzzzv")
k("n", "J", "mzJ`z")

k("n", "p", "p`]", { desc = "Cursor jumps to end of pasted text" })
k("x", "p", '"_dP')

k("x", "<", "<gv")
k("x", ">", ">gv")

k("n", "[e", "g;", { desc = "Go to older position in change list." })
k("n", "]e", "g,", { desc = "Go to [count] newer position in change list" })
k("n", "]l", "<cmd>lnext<CR>zz")
k("n", "[l", "<cmd>lprev<CR>zz")
k("n", "]c", "<cmd>cnext<CR>zz")
k("n", "[c", "<cmd>cprev<CR>zz")

k("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { silent = false })
k("x", "<leader>r", function()
  vim.cmd('normal! "zy')
  local search = vim.fn.escape(vim.fn.getreg("z"), "/\\.")
  vim.fn.feedkeys(":%s/" .. search .. "/", "n")
end, { desc = "Substitute across file using visual selection", silent = false })

-- k("n", "<leader>w", "<cmd>update<CR>")
k("n", "<leader>w", function()
  vim.cmd.update()
  vim.defer_fn(function()
    vim.cmd("echo")
  end, 500)
end)
k("n", "<leader>n", function()
  vim.cmd.nohlsearch()
  vim.cmd("echo")
end)

k("n", "<leader>q", "<cmd>silent xit<CR>")
k("n", "Q", "<cmd>confirm qall<CR>", { desc = "Quit all (confirm)" })

k("n", "<leader><leader>", function()
  local alt = vim.fn.bufnr("#")
  if alt ~= -1 then
    vim.api.nvim_set_current_buf(alt)
  end
  vim.cmd("echo")
end, { desc = "Last buffer" })

k("n", "<leader>z", "<cmd>InspectTree<CR>")

local function toggle_conceallevel()
  vim.opt_local.conceallevel = vim.opt_local.conceallevel:get() > 0 and 0 or 2
end

k("n", "<leader>i", toggle_conceallevel)

k("n", "u", "<cmd>silent undo<CR>")
k("n", "<C-r>", "<cmd>silent redo<CR>")
