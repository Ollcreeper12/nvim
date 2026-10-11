return {
	"folke/which-key.nvim",
	event = "VeryLazy",

	opts = {
		preset = "modern",
		delay = 300,
		spec = {
			{ "<leader>w", desc = "Close buffer" },
			{ "<leader>w", desc = "Close buffer" },
			{ "<leader>e", desc = "Toggle file explorer" },

			-- Find files and search.
			{ "<leader>ff", desc = "Find files" },
			{ "<leader>fp", desc = "Search project text" },
			{ "<leader>fh", desc = "Search help" },

			-- Git actions.
			{ "<leader>gp", desc = "Preview hunk" },
			{ "<leader>gb", desc = "Blame line" },

			-- LSP actions.
			{ "<leader>rn", desc = "Rename symbol" },
			{ "<leader>ca", desc = "Code actions" },
			{ "<leader>d", desc = "Line diagnostics" },

			{ "<leader>v", desc = "Vertical split" },
			{ "<leader>h", desc = "Horizontal split" },
			{ "<leader>=", desc = "Equalise window sizes" },
		},
	},
}
