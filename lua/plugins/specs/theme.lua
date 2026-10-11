return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	opts = {
		integrations = {
			blink_cmp = true,
			bufferline = true,

			-- Match mini.indentscope to Catppuccin's palette.
			mini = {
				enabled = true,
				indentscope_color = "",
			},
		},
	},

	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin-mocha")

		vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#45475a" }) -- Active scope
		vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#89b4fa" }) -- Active scope
	end,
}
