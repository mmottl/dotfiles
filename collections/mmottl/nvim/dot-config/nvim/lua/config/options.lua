-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Yes, we have a Nerd Font
vim.g.have_nerd_font = true

-- wrap long lines with indent
vim.opt.breakindent = true

-- Sets how Neovim will display certain whitespace characters in the editor
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Wrap cursor when moving past beginning or end of line
vim.opt.whichwrap = "b,s,h,l,<,>,~,[,]"

-- Disable autopairs
vim.g.minipairs_disable = true

-- DEBUG settings

-- vim.lsp.set_log_level(vim.log.levels.DEBUG)
