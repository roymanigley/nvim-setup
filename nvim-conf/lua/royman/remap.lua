vim.g.mapleader = " "
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.keymap.set("n", "<C-d>", ":q<CR>")
vim.keymap.set("n", "<C-e>", ":Ex<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<ESC><C-d>", ":q<CR>")
vim.keymap.set("i", "<ESC><C-e>", ":Ex<CR>")
vim.keymap.set("i", "<ESC><C-s>", ":w<CR>")
