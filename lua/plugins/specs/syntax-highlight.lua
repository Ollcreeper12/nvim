return {
	"nvim-treesitter/nvim-treesitter",

	-- Use the compatible master branch.
	branch = "master",

	lazy = false,
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter").setup()

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"python",
				"lua",
				"vim",
				"latex",
				"javascript",
				"typescript",
				"tsx",
				"jsx",
				"html",
				"css",
				"bash",
				"json",
				"markdown",
				"markdown_inline",
				"c",
				"cpp",
				"query",
			},
			callback = function()
				pcall(vim.treesitter.start, 0)
			end,
		})
	end,
}
