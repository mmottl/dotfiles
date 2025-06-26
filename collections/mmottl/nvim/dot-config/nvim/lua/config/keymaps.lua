-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", function()
  -- Clear search highlights
  vim.cmd.nohlsearch()

  -- Clear Codeium completions if available
  local has_codeium, codeium = pcall(require, "codeium")
  if has_codeium and codeium.clear_completions then
    codeium.clear_completions()
  end
end)

-- Duplicate a line and comment out the first line
vim.keymap.set("n", "yc", "yygccp", { remap = true })
