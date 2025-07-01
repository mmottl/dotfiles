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
      "ravitemer/codecompanion-history.nvim",
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
        ["General Assistant"] = {
          strategy = "chat",
          description = "A general assistant",
          opts = {
            index = 20,
            short_name = "assistant",
            ignore_system_prompt = true,
            -- Configure accordingly, preferably in a private file, e.g.:
            -- adapter = {
            --   name = "gemini_flash",
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

        ["Smart General Assistant"] = {
          strategy = "chat",
          description = "A smart general assistant",
          opts = {
            index = 21,
            short_name = "thinker",
            ignore_system_prompt = true,
            -- Configure accordingly, preferably in a private file, e.g.:
            -- adapter = {
            --   name = "gemini_pro",
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
          description = "A fast general assistant",
          opts = {
            index = 22,
            short_name = "speeder",
            ignore_system_prompt = true,
            -- Configure accordingly, preferably in a private file, e.g.:
            -- adapter = {
            --   name = "gemini_flash_lite",
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

        ["Simplify code"] = {
          strategy = "chat",
          description = "Simplify the selected code",
          opts = {
            index = 23,
            is_default = false,
            is_slash_cmd = false,
            modes = { "v" },
            short_name = "simplify",
            auto_submit = true,
            user_prompt = false,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = [[When asked to simplify code, follow these steps:

1.  **Analyze the Code**: Understand the purpose and logic of the provided code snippet.
2.  **Identify Simplification Opportunities**: Look for complex control flow (e.g., nested loops, deep conditionals), manual implementations of standard algorithms/functions, or verbose code that could be replaced by higher-level abstractions or standard library features.
3.  **Plan the Simplification**: Describe the plan for simplifying the code in pseudocode, detailing each step. Focus on using standard functions/operators and reducing control flow complexity.
4.  **Implement the Simplification**: Write the simplified code in a single code block.
5.  **Explain the Simplification**: Briefly explain the changes made, why they simplify the code, and confirm functional equivalence.

Ensure the simplified code:

-   Is functionally equivalent to the original code.
-   Uses standard library functions, operators, or simpler language constructs where possible.
-   Leverages higher-level abstractions (e.g., map, filter, list comprehensions) if they improve clarity without sacrificing performance significantly.
-   Reduces unnecessary control flow statements (e.g., if/else, loops) where appropriate.
-   Maintains or improves readability.
-   Does not increase the computational complexity of the algorithm. Avoid changes that would make the code noticeably slower for typical inputs.
-   Is formatted correctly.

Use Markdown formatting and include the programming language name at the start of the code block.]],
              opts = {
                visible = false,
              },
            },
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(
                  context.start_line,
                  context.end_line
                )
                local fmt = string.format

                return fmt(
                  [[Please simplify this code from buffer %d:

```%s
%s
```

]],
                  context.bufnr,
                  context.filetype,
                  code
                )
              end,
              opts = {
                contains_code = true,
              },
            },
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
            picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
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
