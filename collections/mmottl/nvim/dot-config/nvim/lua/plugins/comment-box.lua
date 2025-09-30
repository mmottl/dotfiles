return {
  "LudoPinelli/comment-box.nvim",
  config = function()
    local wk = require("which-key")
    wk.add({
      { "gcb", "<Cmd>CBccbox<CR>", desc = "Box Title", mode = "n" },
    })
  end,
}
