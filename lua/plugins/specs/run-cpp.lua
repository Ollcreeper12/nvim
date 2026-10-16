return {
	dir = vim.fn.stdpath("config") .. "/lua/plugins/run-cpp",
	name = "run-cpp",
	config = function()
		require("run-cpp").setup()
	end,
}
