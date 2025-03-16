return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "dracula",
      },
      winbar = {
        lualine_c = {
          {
            "filename",
            path = 3, -- Show absolute path, with tilde as home directory
            shorting_target = 80, -- Shorten if path is longer than 80 chars
            file_status = true,
            cond = function()
              return vim.fn.expand("%:t") ~= ""
            end,
          },
        },
        lualine_z = {
          "selection",
          {
            function()
              local starts = vim.fn.line("v")
              local ends = vim.fn.line(".")
              local count = starts <= ends and ends - starts + 1
                or starts - ends + 1
              local wc = vim.fn.wordcount()
              return count .. ":" .. wc["visual_chars"]
            end,
            cond = function()
              return vim.fn.mode():find("[Vv]") ~= nil
            end,
            color = { fg = "black", bg = "#EEFD7A", gui = "bold" },
          },
        },
      },
      inactive_winbar = {
        lualine_c = {
          {
            "filename",
            path = 3, -- Show absolute path, with tilde as home directory
            shorting_target = 80, -- Shorten if path is longer than 80 chars
            file_status = true,
            cond = function()
              return vim.fn.expand("%:t") ~= ""
            end,
          },
        },
      },
    })
  end,
}
