local function augroup(name) return vim.api.nvim_create_augroup("jedi_" .. name, { clear = true }) end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function() vim.hl.on_yank({ higroup = "IncSearch", timeout = 100 }) end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("newline_comment"),
  pattern = "*",
  callback = function() vim.opt_local.formatoptions:remove({ "r", "o" }) end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.conceallevel = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("clangd_mappings"),
  pattern = "c",
  callback = function()
    vim.keymap.set("n", "<leader>h", "<cmd>LspClangdSwitchSourceHeader<CR>", { silent = true })
  end,
})
