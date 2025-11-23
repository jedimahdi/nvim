local highlight_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_group,
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- restore cursor to file position in previous editing session
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   callback = function(args)
--     local buftype = vim.bo[args.buf].buftype
--     local filetype = vim.bo[args.buf].filetype
--
--     -- skip special buffers
--     if buftype ~= "" then
--       return
--     end
--     if filetype == "help" or filetype == "qf" or filetype == "oil" then
--       return
--     end
--
--     local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
--     local line_count = vim.api.nvim_buf_line_count(args.buf)
--
--     if mark[1] > 0 and mark[1] <= line_count then
--       vim.api.nvim_win_set_cursor(0, mark)
--     end
--   end,
-- })
