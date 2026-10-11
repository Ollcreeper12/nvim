return {

	"L3MON4D3/LuaSnip",
	version = "2.8",

	dependencies = {
		"rafamadriz/friendly-snippets",
	},

	config = function()
		local ls = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		ls.add_snippets("python", require("snippets.python"))
		ls.add_snippets("tex", require("snippets.latex"))
		ls.add_snippets("lua", require("snippets.lua"))
	end,
}
