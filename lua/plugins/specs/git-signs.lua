return {
  "lewis6991/gitsigns.nvim",
  lazy = false,

  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      chagnedelete = { text = "~" },
    },
  },
  config = function (_, opts)
    require("gitsigns").setup(opts)
  end
  
}
