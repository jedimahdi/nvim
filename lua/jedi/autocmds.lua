local highlight_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_group,
  callback = function() vim.hl.on_yank({ higroup = "IncSearch", timeout = 100 }) end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function() vim.opt_local.formatoptions:remove({ "r", "o" }) end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "rmd", "quarto" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = "nc"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.keymap.set("n", "<leader>h", "<cmd>LspClangdSwitchSourceHeader<CR>", { silent = true })
  end,
})
