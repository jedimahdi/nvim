local Remap = require("jedi.keymap")

local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<space>X", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<C-S>", ":%s/")
vim.keymap.set("v", "<C-S>", ":s/")

inoremap("<C-H>", "<C-w>")

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

-- nnoremap("<leader>e", ":Ex<CR>")
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vnoremap("K", ":m '<-2<CR>gv=gv")
vnoremap("J", ":m '>+1<CR>gv=gv")

nnoremap("Y", "yg$")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")
-- nnoremap("<C-d>", "<C-d>zz")
-- nnoremap("<C-u>", "<C-u>zz")

-- greatest remap ever
xnoremap("<leader>p", '"_dP')

nnoremap("<C-n>", "<cmd>cnext<CR>zz")
nnoremap("<C-p>", "<cmd>cprev<CR>zz")
nnoremap("<leader>k", "<cmd>lnext<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")

nnoremap("<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("v", "<leader>r", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

nnoremap("<leader>w", "<cmd>silent update<CR>")
nnoremap("<leader>q", "<cmd>silent xit<CR>")
nnoremap("Q", "<cmd>xall<CR>")
nnoremap("<leader><leader>", "<cmd>buffer#<CR>")

nnoremap("<leader>z", "<cmd>InspectTree<CR>")

-- Format
nnoremap("<leader>p", function()
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls" or client.name == "rust_analyzer" or client.name == "ols"
    end,
  })
end)

nnoremap("<leader>n", "<cmd>nohls<CR>")
nnoremap("K", function() end)

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

-- nnoremap("<leader>y", '"+y')
-- vnoremap("<leader>y", '"+y')
-- nmap("<leader>Y", '"+Y')
-- nnoremap("<leader>d", '"_d')
-- vnoremap("<leader>d", '"_d')
-- vnoremap("<leader>d", '"_d')
-- inoremap("<C-c>", "<Esc>")
