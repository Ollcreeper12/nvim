return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "C:/Users/OllCreeper/AppData/Local/SumatraPDF/SumatraPDF.exe"
      vim.g.vimtex_view_general_options = "-reuse-instance -farward-search @tex @line @pdf"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-pdf",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-file-line-error",
        },
      }
      vim.g.vimtex_quickfix_mode = 0
      
      vim.o.conceallevel = 2
      vim.o.concealcursor = "nc"

      vim.g.vimtex_syntax_conceal = {
        acccents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        spacing = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 1,
        styles = 1,
      }

    end,
  }
}
