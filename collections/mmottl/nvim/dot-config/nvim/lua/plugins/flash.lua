return {
  "folke/flash.nvim",
  opts = {
    modes = {
      char = {
        char_actions = function(motion)
          return {
            -- Don't use [fFtT] motion keys
            [";"] = "next", -- set to `right` to always go right
            [","] = "prev", -- set to `left` to always go left
          }
        end,
      },
    },
  },
}
