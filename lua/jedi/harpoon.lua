local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon.setup({})

vim.keymap.set("n", "<leader>sa", require("harpoon.mark").add_file, { desc = "Harpoon add file" })
vim.keymap.set("n", "<leader>sm", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon quick menu" })

for i = 1, 5 do
  vim.keymap.set("n", string.format("<leader>%s", i), function()
    require("harpoon.ui").nav_file(i)
  end, { desc = "Harpoon nav i" })
end
