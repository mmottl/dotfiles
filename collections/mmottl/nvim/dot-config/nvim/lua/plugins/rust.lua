return {
  "rust-lang/rust.vim",
  keys = {
    {
      "gm",
      ":RustLsp expandMacro<CR>",
      mode = { "n" },
      noremap = true,
      silent = true,
      desc = "Expand Macro (RustLsp)",
    },
  },
}
