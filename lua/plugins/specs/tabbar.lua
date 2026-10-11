return {

  -- dir = vim.fn.stdpath("config") .. "/lua/plugins/tabbar",

  -- name = "ui-bar",
  -- lazy = false,

  -- dependoncies = { "nvim-tree/nvim-web-devicons" },

  -- config = function ()
  --   require("tabbar").setup()
  -- end

	"akinsho/bufferline.nvim",
	version = "*",
	dependoncies = { "nvim-tree/nvim-web-devicons" },

	opts = {
		options = {
			mode = "buffers",
			numbers = "none",
			diagnostics = "nvim_lsp",
			separator_style = "slant",
			show_buffer_close_icons = false,
			show_close_icon = false,
			color_icons = true,
			always_show_bufferline = false,

			custom_filter = function(buf)
				local name = vim.api.nvim_buf_get_name(buf)
				return vim.fn.isdirectory(name) == 0
			end,

      truncate_names = true,
      max_name_length = 24,
      tab_size = 20,
      padding = -1,

      modified_icon = "●",
      -- indicator = {
      --   style = "underline"
      -- },

      name_formatter = function (buf)
        return buf.name
      end
		},
	},
}
