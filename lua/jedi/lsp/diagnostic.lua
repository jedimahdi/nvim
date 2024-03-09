vim.diagnostic.config({
  underline = false,
  signs = false,
  severity_sort = true,
  update_in_insert = false,
})

local severity_levels = {
  vim.diagnostic.severity.ERROR,
  vim.diagnostic.severity.WARN,
  vim.diagnostic.severity.INFO,
  vim.diagnostic.severity.HINT,
}

local get_highest_error_severity = function()
  for _, level in ipairs(severity_levels) do
    local diags = vim.diagnostic.get(0, { severity = { min = level } })
    if #diags > 0 then
      return level, diags
    end
  end
end

vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({
    severity = get_highest_error_severity(),
    wrap = true,
    float = true,
  })
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({
    severity = get_highest_error_severity(),
    wrap = true,
    float = true,
  })
end)
vim.keymap.set("n", "<leader>a", function()
  vim.diagnostic.open_float(0, {
    scope = "line",
  })
end)
