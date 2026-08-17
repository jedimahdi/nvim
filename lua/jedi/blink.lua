local M = {}

---@module 'blink.cmp'
---@type blink.cmp.Config
M.opts = {
  keymap = {
    preset = "none",
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },
    ["<C-y>"] = { "select_and_accept", "fallback" },
    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  },
  sources = {
    default = { "lsp", "path", "buffer" },
    providers = {
      buffer = {
        min_keyword_length = 4,
      },
    },
  },
  completion = {
    accept = { auto_brackets = { enabled = false } },
    menu = {
      auto_show = true,
      draw = {
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
      },
    },
    list = { selection = { preselect = false, auto_insert = true } },
    documentation = { auto_show = true, auto_show_delay_ms = 0 },
    -- ghost_text = { enabled = true, show_with_menu = true },
  },
  appearance = {
    nerd_font_variant = "normal",
  },
}

return M
