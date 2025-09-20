return {
  "folke/snacks.nvim",
  opts = {
    image = {
      enabled = true,
    },
    picker = {
      formatters = {
        file = {
          truncate = 60,
        },
      },
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
      win = {
        input = {
          keys = {
            ["<a-j>"] = { "history_forward", mode = { "i", "n" } },
            ["<a-k>"] = { "history_back", mode = { "i", "n" } },
          },
        },
      },
    },
    zen = {
      show = { statusline = true, tabline = true },
      toggles = { dim = false },
      win = {
        width = 120,
      },
    },
  },
}
