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
        ["Fast General Assistant"] = {
          strategy = "chat",
          description = "A fast general assistant",
          opts = {
            index = 20,
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

        ["Smart General Assistant"] = {
          strategy = "chat",
          description = "A smart general assistant",
          opts = {
            index = 21,
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

        ["Simplify code"] = {
          strategy = "chat",
          description = "Simplify the selected code",
          opts = {
            index = 22,
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
