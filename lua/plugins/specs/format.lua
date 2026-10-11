return {
  "stevearc/conform.nvim",

  event = {"BufWritePre"},

  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
    },

    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
  },
}
