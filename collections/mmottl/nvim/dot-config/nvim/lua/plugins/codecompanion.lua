-- Prompt used for the general AI assistant
local assistant_system_prompt = "You are a versatile AI assistant, always ready to "
  .. "help. Provide responses that are accurate, helpful, and also concise."
  .. " Assist users with tasks like writing, summarization, and brainstorming."
  .. " You can also help with coding and learning by using your language capabilities."
  .. " Prioritize factual accuracy, and clearly state when you lack needed information."
  .. " Also state clearly when you cannot fulfill a specific user request."
  .. " Avoid any speculation or generating content that is potentially false."
  .. " Adapt your tone and writing style to be helpful, meeting user needs."
  .. " Always be informative for the user's specific contextual needs."

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
      "j-hui/fidget.nvim",
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
              return "  CodeCompanion (" .. adapter.formatted_name .. ")"
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

      prompt_library = {
        ["Smart General Assistant"] = {
          strategy = "chat",
          description = "A general assistant - smart but not the fastest",
          opts = {
            short_name = "thinker",
            ignore_system_prompt = true,
            -- Configure accordingly, preferably in a private file
            -- adapter = {
            --   name = "g25",
            -- },
          },
          prompts = {
            {
              role = "system",
              content = assistant_system_prompt,
            },
            {
              role = "user",
              content = " ",
            },
          },
        },

        ["Fast General Assistant"] = {
          strategy = "chat",
          description = "A general assistant - fast but not the smartest",
          opts = {
            short_name = "assistant",
            ignore_system_prompt = true,
            -- Configure accordingly, preferably in a private file
            -- adapter = {
            --   name = "gfl",
            -- },
          },
          prompts = {
            {
              role = "system",
              content = assistant_system_prompt,
            },
            {
              role = "user",
              content = " ",
            },
          },
        },
      },
    },

    init = function()
      require("plugins.codecompanion.fidget-spinner"):init()
    end,

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
