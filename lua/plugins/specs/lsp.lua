return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
	},

	{
		"mason-org/mason.nvim",
		opts = {},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"texlab",
			},
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							},
							checkThirdParty = false,
						},
					},
				},
			})

			vim.lsp.enable({
				"lua_ls",
				"pyright",
				"texlab",
			})
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},
}
