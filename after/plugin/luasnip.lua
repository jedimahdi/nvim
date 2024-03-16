local ls = require("luasnip")

-- <c-j> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
-- vim.keymap.set({ "i", "s" }, "<c-k>", function()
--   if ls.expand_or_jumpable() then
--     ls.expand_or_jump()
--   end
-- end, { silent = true })

-- <c-k> is my jump backwards key.
-- this always moves to the previous item within the snippet
-- vim.keymap.set({ "i", "s" }, "<c-i>", function()
--   if ls.jumpable(-1) then
--     ls.jump(-1)
--   end
-- end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
-- vim.keymap.set("i", "<c-l>", function()
--   if ls.choice_active() then
--     ls.change_choice(1)
--   end
-- end)

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.s
local f = ls.function_node
local t = ls.t
local i = ls.i

local same = function(index)
  return f(function(args)
    return args[1]
  end, { index })
end

ls.add_snippets("haskell", {
  s(
    "main",
    fmt(
      [[
main :: IO ()
main = do
  {}
  pure ()
]],
      i(0)
    )
  ),
})

ls.add_snippets("lua", {
  s("simple", t("wow, you were right!")),
})

ls.add_snippets("typescript", {
  s("cl", fmt("console.log({});", i(1))),
})
