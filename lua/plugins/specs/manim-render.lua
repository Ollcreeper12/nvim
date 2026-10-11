return {
	dir = vim.fn.stdpath("config") .. "/lua/plugins/manim-render",
	name = "manim-render",
	lazy = false,

	config = function()
		require("manim_render").setup()
	end,
}
