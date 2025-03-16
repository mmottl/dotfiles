return {
  "CopilotC-Nvim/CopilotChat.nvim",
  enabled = false,
  opts = function()
    return {
      model = "claude-3.5-sonnet",
      -- model = "gpt-4o",
      question_header = "  Me",
    }
  end,
}
