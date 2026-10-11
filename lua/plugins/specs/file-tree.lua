return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,

	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		require("nvim-tree").setup({
			view = {
				width = 30,
				side = "left",
			},
			renderer = {
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
				indent_markers = { enable = true },
			},
			git = { enable = true },
			hijack_directories = { enable = false },
		})
	end,
}
