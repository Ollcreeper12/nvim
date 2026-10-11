-- Configure Telescope fuzzy finding.
return {
	"nvim-telescope/telescope.nvim",

	-- Use the stable release.
	version = false,
	-- Load Telescope during startup.
	lazy = false,

	-- Load Telescope's required utility library.
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	-- Telescope settings (must be named opts).
	opts = {
		defaults = {
			-- Put the search prompt at the top.
			sorting_strategy = "ascending",

			-- Configure the picker layout.
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
				},
				width = 0.9,
				height = 0.8,
			},

			-- Set the search prompt and selection indicator.
			prompt_prefix = "  ",
			selection_caret = " ",
		},

		-- Configure individual pickers.
		pickers = {
			find_files = {
				hidden = true,
			},
		},
	},
}
