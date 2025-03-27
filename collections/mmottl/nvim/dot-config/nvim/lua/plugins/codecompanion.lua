return {
  {
    "olimorris/codecompanion.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
      },
    },

    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionAdd",
      "CodeCompanionChat",
      "CodeCompanionToggle",
    },

    opts = {
      -- Configure `adapters` (e.g. tokens) in a private configuration file.
      -- Use GPG and something like:
      --   api_key = "cmd:gpg --batch --quiet --decrypt path-to-encrypted-token.gpg",
      strategies = {
        inline = {
          adapter = "openai",
        },
        chat = {
          adapter = "openai",
          roles = {
            llm = function(adapter)
              return "  " .. adapter.formatted_name
            end,
            user = "  Me",
          },
          keymaps = {
            close = {
              modes = {
                n = "Q",
                i = "<Nop>",
              },
              noremap = true,
              silent = true,
              index = 4,
              callback = "keymaps.close",
              description = "Close Chat",
            },
          },
        },
      },
      display = {
        chat = {
          -- show_settings = true,
          window = {
            layout = "horizontal",
            position = "bottom",
            height = 0.45,
            width = 0.8,
          },
        },
      },
    },

    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>at",
        ":CodeCompanionChat Toggle<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "Toggle (CodeCompanion)",
      },
      {
        "<leader>an",
        ":CodeCompanionChat<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "New Chat (CodeCompanion)",
      },
      {
        "<leader>aa",
        ":CodeCompanionActions<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "Prompt Actions (CodeCompanion)",
      },
      {
        "<leader>ad",
        ":CodeCompanionChat Add<cr>",
        mode = "v",
        noremap = true,
        silent = true,
        desc = "Add Code (CodeCompanion)",
      },
      {
        "<leader>ai",
        ":CodeCompanion<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "Inline Prompt (CodeCompanion)",
      },
    },
  },

  -- Edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "CodeCompanion Chat",
        size = { width = 50 },
      })
    end,
  },
}
