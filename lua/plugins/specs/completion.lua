return {
	"saghen/blink.cmp",
	version = "1.*",

	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
	},

	opts = {
		cmdline = {
			completion = {
				menu = {
					auto_show = true,
				},
			},
		},
		completion = {
			menu = {
				--       auto_show = true
				border = "rounded",
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "source_name" },
					},
					treesitter = { "lsp" },
				},
			},

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
		},
		keymap = {
			preset = "default",
			["<Tab>"] = {
				"select_next",
				"fallback",
			},
			["<S-Tab>"] = {
				"select_prev",
				"fallback",
			},
			["<CR>"] = {
				"accept",
				"fallback",
			},
			["<Esc>"] = {
				"hide",
				"fallback",
			},
		},

		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
		},
		signature = {
			enabled = true,
		},
		snippets = {
			preset = "luasnip",
		},
	},
}
