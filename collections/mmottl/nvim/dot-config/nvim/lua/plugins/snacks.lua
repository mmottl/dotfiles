return {
  "folke/snacks.nvim",
  opts = {
    image = {
      -- enabled = true,
      doc = {
        -- inline = true,
        -- float = true,
        max_width = 120,
        max_height = 90,
      },
      convert = {
        mermaid = function()
          local theme = vim.o.background == "light" and "neutral" or "dark"
          return {
            "-i",
            "{src}",
            "-o",
            "{file}",
            "-b",
            "transparent",
            "-t",
            theme,
            "-s",
            -- "{scale}",
            "3", -- 3 seems better
          }
        end,
      },
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
  keys = {
    {
      "<leader>im",
      ft = { "tex", "markdown" },
      function()
        if vim.b.is_image_hover_active == nil then
          vim.b.is_image_hover_active = false
        end

        if vim.b.is_image_hover_active then
          Snacks.image.doc.hover_close()
          vim.b.is_image_hover_active = false
        else
          Snacks.image.doc.hover()
          vim.b.is_image_hover_active = true
        end
      end,
      desc = "Preview image under cursor",
    },
  },
}
