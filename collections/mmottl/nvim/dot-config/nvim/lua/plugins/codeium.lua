return {
  "Exafunction/codeium.nvim",
  config = function()
    local virtual_text = require("codeium.virtual_text")
    -- Get codeium's augroup
    local augroup =
      vim.api.nvim_create_augroup("codeium_virtual_text", { clear = false })
    -- Hook into User.InsertLeaveCtrlC to clear virtual text.
    vim.api.nvim_create_autocmd("User", {
      group = augroup,
      pattern = "InsertLeaveCtrlC",
      callback = function()
        virtual_text.clear()
      end,
    })

    -- Trigger autocmd `User.InsertLeaveCtrlC` when <C-c> is pressed
    vim.api.nvim_set_keymap(
      "i",
      "<C-c>",
      [[<Esc>:doautocmd User InsertLeaveCtrlC<CR>]],
      { noremap = true, silent = true }
    )

    require("codeium").setup({
      enable_cmp_source = true,
      -- Optionally disable cmp source if using virtual text only
      -- enable_cmp_source = false,
      virtual_text = {
        -- enabled = true,
        --
        --   -- These are the defaults
        --
        --   -- Set to true if you never want completions to be shown automatically.
        --   manual = false,
        --   -- A mapping of filetype to true or false, to enable virtual text.
        --   filetypes = {},
        --   -- Whether to enable virtual text of not for filetypes not specifically listed above.
        --   default_filetype_enabled = true,
        --   -- How long to wait (in ms) before requesting completions after typing stops.
        --   idle_delay = 75,
        --   -- Priority of the virtual text. This usually ensures that the completions appear on top of
        --   -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
        --   -- desired.
        --   virtual_text_priority = 65535,
        --   -- Set to false to disable all key bindings for managing completions.
        --   map_keys = true,
        --   -- The key to press when hitting the accept keybinding but no completion is showing.
        --   -- Defaults to \t normally or <c-n> when a popup is showing.
        --   accept_fallback = nil,
        --   -- Key bindings for managing completions in virtual text mode.
        --   key_bindings = {
        --     -- Accept the current completion.
        --     accept = "<Tab>",
        --     -- Accept the next word.
        --     accept_word = false,
        --     -- Accept the next line.
        --     accept_line = false,
        --     -- Clear the virtual text.
        --     clear = false,
        --     -- Cycle to the next completion.
        --     next = "<M-]>",
        --     -- Cycle to the previous completion.
        --     prev = "<M-[>",
        --   },
      },
    })
  end,
}
