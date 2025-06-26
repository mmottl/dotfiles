-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Safe autochdir implementation
vim.api.nvim_create_autocmd({
  "VimEnter",
  "BufReadPost",
  "BufEnter",
  "BufWinEnter",
  "BufNewFile",
  "BufAdd",
}, {
  group = vim.api.nvim_create_augroup("safe-autochdir", { clear = true }),
  callback = function()
    -- List of filetypes to ignore
    local ignored_filetypes = {
      "", -- Empty filetype
      "DiffviewFileHistory",
      "NeogitCommitMessage",
      "gitcommit",
      "help",
      "nofile",
      "qf",
      "quickfix",
      "terminal",
    }

    -- Safety checks
    local can_autochdir = true
    -- Don't mess with vim on startup
    can_autochdir = can_autochdir and (vim.v.vim_did_enter == 1)
    can_autochdir = can_autochdir
      -- Check ignored filetypes
      and not vim.tbl_contains(ignored_filetypes, vim.bo.filetype)
    can_autochdir = can_autochdir
      -- Only change for readable files
      and vim.fn.filereadable(vim.fn.expand("%")) == 1
    can_autochdir = can_autochdir and vim.bo.modifiable
    can_autochdir = can_autochdir
      -- Only for absolute paths
      and (vim.fn.expand("%:p"):match("^/") ~= nil)

    if can_autochdir then
      local path = vim.fn.expand("%:p:h")
      vim.cmd.cd(path)
    end
  end,
})

-- Recognize *.gitconfig filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gitconfig",
  callback = function()
    vim.bo.filetype = "gitconfig"
  end,
})

-- LSP Autocompletion
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if
      client
      and client:supports_method("textDocument/completion")
      and ev
      and ev.buf
    then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen", "TermClose" }, {
  group = vim.api.nvim_create_augroup(
    "terminal_keybindings_override",
    { clear = true }
  ),
  callback = function(ev)
    if ev.event == "TermOpen" then
      -- When a terminal is opened, ensure <C-l> is passed through to the terminal.
      -- This allows the terminal's native clear screen (Ctrl-L) to function.
      -- Use the usual Vim-derived mapping <C-w><C-l> to move to the left
      -- window.
      vim.keymap.set("t", "<C-l>", "<C-l>", {
        buffer = ev.buf,
        noremap = false,
        silent = true,
        desc = "Pass <C-l> to terminal for clear screen",
      })
    elseif ev.event == "TermClose" then
      -- When a terminal is closed, remove the buffer-local <C-l> mapping
      -- to restore any global Neovim mappings.
      vim.keymap.del("t", "<C-l>", { buffer = ev.buf })
    end
  end,
})
