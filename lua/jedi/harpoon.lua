local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon:setup({})

vim.keymap.set("n", "<leader>sa", function()
  harpoon:list():add()
end, { desc = "Harpoon add file" })
vim.keymap.set("n", "<leader>ss", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon quick menu" })

for i = 1, 5 do
  vim.keymap.set("n", string.format("<leader>%s", i), function()
    harpoon:list():select(i)
  end, { desc = "Harpoon uuquick menu" })
end
