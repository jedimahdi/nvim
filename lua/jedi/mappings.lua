local function k(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.noremap = opts.noremap ~= false

  vim.keymap.set(mode, lhs, rhs, opts)
end

k({ "n", "v" }, "<Space>", "<Nop>")

k("n", "<C-S>", ":%s/", { silent = false })
k("v", "<C-S>", ":s/", { silent = false })

k("i", "<C-H>", "<C-w>")

k({ "n", "x" }, "c", '"_c')
k("n", "cc", '"_cc')
k("n", "C", '"_C')

k({ "n", "x" }, "x", '"_x')

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

k("x", "<leader>p", '"_dP')

k("n", "<C-n>", "<cmd>lnext<CR>zz")
k("n", "<C-p>", "<cmd>lprev<CR>zz")
k("n", "<leader>k", "<cmd>cnext<CR>zz")
k("n", "<leader>j", "<cmd>cprev<CR>zz")

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
    vim.cmd("echo ''")
  end, 500)
end)
k("n", "<leader>n", function()
  vim.cmd.nohlsearch()
  vim.cmd("echo ''")
end)

k("n", "<leader>q", "<cmd>silent xit<CR>")
k("n", "Q", "<cmd>xall<CR>")
k("n", "<leader><leader>", function()
  local alt = vim.fn.bufnr("#")
  if alt ~= -1 then
    vim.api.nvim_set_current_buf(alt)
  end
end)

k("n", "<leader>z", "<cmd>InspectTree<CR>")

k("n", "<M-j>", function()
  if vim.opt.diff:get() then
    vim.cmd([[normal! ]c]])
  else
    vim.cmd([[m .+1<CR>==]])
  end
end)

k("n", "<M-k>", function()
  if vim.opt.diff:get() then
    vim.cmd([[normal! [c]])
  else
    vim.cmd([[m .-2<CR>==]])
  end
end)

local function toggle_conceallevel()
  vim.opt.conceallevel = vim.opt.conceallevel:get() > 0 and 0 or 2
end

k("n", "<leader>c", toggle_conceallevel)
