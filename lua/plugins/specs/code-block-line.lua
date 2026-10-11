-- LazyVim-style indent scope indicator.
return {
	"folke/snacks.nvim",
	version = false,
	event = { "BufReadPost", "BufNewFile" },

	opts = {
    indent = {
      enabeled = true,
		  -- Character used for the vertical line.
		  char = "│",

		  -- Recognise the line above a block as its boundary.
	    scope = {
        enabled = true,
        char = "│",
      },
    },
  },
}
