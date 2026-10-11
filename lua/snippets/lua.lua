local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s("nplugsetup", {
		t({ "function M.setup()", "  " }),
		i(1, "-- Tod0 --"),
		t({ "", "end" }),
	}),
}
