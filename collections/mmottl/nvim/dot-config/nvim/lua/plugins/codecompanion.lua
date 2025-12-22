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
      "lalitmee/codecompanion-spinners.nvim",
      "ravitemer/codecompanion-history.nvim",
      "ravitemer/mcphub.nvim",
    },

    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionAdd",
      "CodeCompanionChat",
      "CodeCompanionToggle",
    },

    opts = {
      -- For debugging
      -- opts = {
      --   log_level = "TRACE",
      -- },

      -- Configure `adapters` (e.g. tokens) in a private configuration file.
      -- Use GPG and something like:
      --   api_key = "cmd:gpg --batch --quiet --decrypt path-to-encrypted-token.gpg",
      interactions = {
        inline = {
          adapter = "openai",
        },

        chat = {
          adapter = "openai",
          roles = {
            user = "  Me",
            llm = function(adapter)
              return "  CodeCompanion (" .. adapter.formatted_name .. ")"
            end,
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

          tools = {
            opts = {
              default_tools = {
                -- "files",
                -- "full_stack_dev",
                -- "mcp",
              },
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

      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
            -- Picker interface (auto resolved to a valid picker)
            picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
            -- Customize picker keymaps (optional)
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            ---Automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              ---Adapter for generating titles (defaults to current chat adapter)
              adapter = nil, -- "copilot"
              ---Model for generating titles (defaults to current chat model)
              model = nil, -- "gpt-4o"
              ---Number of user prompts after which to refresh the title (0 to disable)
              refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
              ---Maximum number of times to refresh the title (default: 3)
              max_refreshes = 3,
            },
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,
            ---Optional filter function to control which chats are shown when browsing
            chat_filter = nil, -- function(chat_data) return boolean end
          },
        },

        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },

        spinner = {
          -- enabled = true, -- This is the default
          opts = {
            -- Your spinner configuration goes here
            style = "snacks",
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
      {
        "<leader>ac",
        ":CodeCompanionCmd ",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "Command Mode (CodeCompanion)",
      },
      {
        "<leader>as",
        ":CodeCompanion /simplify<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "Simplify code (CodeCompanion)",
      },
      {
        "<leader>ae",
        ":CodeCompanion /explain<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "Explain code (CodeCompanion)",
      },
      {
        "<leader>aE",
        ":CodeCompanion /lsp<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "Explain LSP Diagnostics (CodeCompanion)",
      },
      {
        "<leader>af",
        ":CodeCompanion /fix<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "Fix code (CodeCompanion)",
      },
    },
  },
}
