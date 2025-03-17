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
  local diags = vim.diagnostic.get(0, {})
  if #diags <= 0 then
    return
  end
  vim.diagnostic.jump({
    severity = get_highest_error_severity(),
    wrap = true,
    float = true,
    count = -1,
  })
end)
vim.keymap.set("n", "]d", function()
  local diags = vim.diagnostic.get(0, {})
  if #diags <= 0 then
    return
  end
  vim.diagnostic.jump({
    severity = get_highest_error_severity(),
    wrap = true,
    float = true,
    count = 1,
  })
end)
vim.keymap.set("n", "<leader>a", function()
  vim.diagnostic.open_float({
    scope = "line",
  })
end)
