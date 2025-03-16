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

-- Function to switch between OCaml interface (.mli) and implementation (.ml) files
local function ocaml_switch(newwin)
  local bufname = vim.fn.bufname()
  local fname

  if bufname:match("%.mli$") then
    fname = bufname:gsub("%.mli$", ".ml")
  elseif bufname:match("%.ml$") then
    fname = bufname .. "i"
  else
    return
  end

  fname = vim.fn.fnameescape(fname)

  if newwin == 1 then
    vim.cmd("new " .. fname)
  else
    vim.cmd("edit " .. fname)
  end
end

-- Set up <Plug> mappings
vim.keymap.set("n", "<Plug>OCamlSwitchEdit", function()
  ocaml_switch(0)
end, {})
vim.keymap.set("n", "<Plug>OCamlSwitchNewWin", function()
  ocaml_switch(1)
end, {})

-- Set up localleader mappings
vim.keymap.set(
  "n",
  "<leader>os",
  "<Plug>OCamlSwitchEdit",
  { desc = "OCaml switch implementation/interface" }
)
vim.keymap.set(
  "n",
  "<leader>oS",
  "<Plug>OCamlSwitchNewWin",
  { desc = "OCaml switch impl/interf (new window)" }
)
