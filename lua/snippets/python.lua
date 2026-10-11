local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	-- Type "main" to create a Python entry point.
	s("@main", {
		t({
			"def main():",
			"    ",
		}),
		i(1, "pass"),
		t({
			"",
			"",
			'if __name__ == "__main__":',
			"    main()",
		}),
	}),

	-- Type "class" to create a Python class.
	s("class", {
		t("class "),
		i(1, "ClassName"),
		t({ ":", "    def __init__(self):", "        " }),
		i(2, "pass"),
	}),
	s("manim_", {
		t("class "),
		i(1, "AnimationName"),
		t({
			"(Scene):",
			"   def construct(self):",
			"     ",
		}),
		i(2, "pass"),
	}),
}
