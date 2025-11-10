vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<leader>X", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

vim.keymap.set("n", "<C-S>", ":%s/")
vim.keymap.set("v", "<C-S>", ":s/")

vim.keymap.set("i", "<C-H>", "<C-w>")

vim.keymap.set({ "n", "x" }, "c", '"_c')
vim.keymap.set("n", "cc", '"_cc')
vim.keymap.set("n", "C", '"_C')

vim.keymap.set({ "n", "x" }, "x", '"_x')

-- Go to the beginning and end of current line in insert mode quickly
vim.keymap.set("i", "<C-A>", "<HOME>")
vim.keymap.set("i", "<C-E>", "<END>")

-- Go to beginning of command in command-line mode
vim.keymap.set("c", "<C-A>", "<HOME>")

-- Delete the character to the right of the cursor
vim.keymap.set("i", "<C-D>", "<DEL>")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<C-n>", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("v", "<leader>r", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", "<leader>w", "<cmd>update<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>silent xit<CR>")
vim.keymap.set("n", "Q", "<cmd>xall<CR>")
vim.keymap.set("n", "<leader><leader>", "<cmd>buffer#<CR>")

vim.keymap.set("n", "<leader>z", "<cmd>InspectTree<CR>")

vim.keymap.set("n", "<leader>p", function()
  require("conform").format({})
end)

vim.keymap.set("n", "<leader>n", "<cmd>nohls<CR>")

vim.keymap.set("n", "<M-j>", function()
  if vim.opt.diff:get() then
    vim.cmd([[normal! ]c]])
  else
    vim.cmd([[m .+1<CR>==]])
  end
end)

vim.keymap.set("n", "<M-k>", function()
  if vim.opt.diff:get() then
    vim.cmd([[normal! [c]])
  else
    vim.cmd([[m .-2<CR>==]])
  end
end)

local function toggle_conceallevel()
  vim.opt.conceallevel = vim.opt.conceallevel:get() > 0 and 0 or 2
end

local function toggle_concealcursor()
  vim.opt.concealcursor = vim.opt.concealcursor:get() == "n" and "" or "n"
end

vim.keymap.set("n", "<F10>", toggle_conceallevel, { noremap = true, silent = true })
vim.keymap.set("n", "<F11>", toggle_concealcursor, { noremap = true, silent = true })
