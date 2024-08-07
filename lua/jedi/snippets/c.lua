require("luasnip.session.snippet_collection").clear_snippets("c")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

ls.add_snippets("c", {
  s("pd", fmt([[printf("{} = %d\n", {});{}]], { rep(1), i(1), i(0) })),
  s("ps", fmt([[printf("{} = %s\n", {});{}]], { rep(1), i(1), i(0) })),
  s("for", fmta("for (int i = 0; i << <cond>; i++) {\n\t<finish>\n}", { cond = i(1), finish = i(0) })),
})
