return {
  "mbbill/undotree",
  lazy = true,
  keys = {
    {
      "<leader>bu",
      function()
        vim.cmd.UndotreeToggle()
      end,
      desc = "Show Undotree",
    },
    config = true,
  },
  init = function()
    vim.g.undotree_WindowLayout = 2
  end,
}
