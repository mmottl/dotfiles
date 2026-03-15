-- Git plugin configuration
require("git"):setup({
  -- Order of status signs showing in the linemode
  order = 1500,
})

-- DuckDB plugin configuration
require("duckdb"):setup()

-- Yatline plugin configuration
require("yatline"):setup()

-- EasyJump plugin configuration
require("easyjump"):setup({
  icon_fg = "#94e2d5", -- color for hint labels
  first_key_fg = "#45475a", -- color for first char of double-key hints
})
