-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<CR>", "o<Esc>", { desc = "Insert new line below and stay in normal mode" })
vim.keymap.set("n", "<S-CR>", "O<Esc>", { desc = "Insert new line above and stay in normal mode" })
vim.keymap.set("i", "<S-{>", "{<CR>}<Esc>O", { desc = "Add new line and enter inside {}" })
