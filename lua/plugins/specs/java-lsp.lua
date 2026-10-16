return {
	"nvim-java/nvim-java",
	lazy = false,

	config = function()
		require("java").setup({})
		vim.lsp.config("jdtls", {})
		vim.lsp.enable("jdtls")
	end,
}
