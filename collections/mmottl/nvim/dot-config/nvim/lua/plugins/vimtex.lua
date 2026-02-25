return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 0
    vim.g.vimtex_view_skim_no_select = 1

    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      executable = "latexmk",
      continuous = 1,
      callback = 1,
      out_dir = "build",
      aux_dir = "build",
      options = {
        "-f",
        "-file-line-error",
        "-interaction=nonstopmode",
        "-synctex=1",
      },
    }
  end,
}
