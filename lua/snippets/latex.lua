local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s("@eq", {
		t({ "\\begin{align*}", "" }),
		i(1, "  Equ"),
		t({ "", "\\end{align*}" }),
	}),
}
