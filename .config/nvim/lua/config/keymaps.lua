-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
---- Map 'jj' to Escape in insert mode
vim.keymap.set({ "i", "v" }, "jj", "<Esc>", { noremap = true, silent = true })
