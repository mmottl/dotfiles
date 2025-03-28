return {
  "folke/snacks.nvim",
  opts = {
    zen = {
      show = { statusline = true, tabline = true },
      toggles = { dim = false },
      win = {
        width = 120,
      },
    },
    picker = {
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["<C-t>"] = "tab",
                ["<M-t>"] = "terminal",
              },
            },
          },
        },
      },
    },
  },
}
