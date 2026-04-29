local map = vim.keymap.set

-- Leader key
vim.g.mapleader = " "

-- Movement
map("n", "j", "gj")
map("n", "k", "gk")
map({ "n", "v" }, "B", "^")
map({ "n", "v" }, "E", "$")

-- Move lines around
map("n", "J", ":m .+1<CR>==")
map("n", "K", ":m .-2<CR>==")
map("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
map("i", "<C-l>", "<Esc>>>i")
map("i", "<C-h>", "<Esc><<i")
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")
map("v", "<C-l>", ">gv")
map("v", "<C-h>", "<gv")

map("n", ">", ">>")
map("n", "<", "<<")

-- Indent keeping selection
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Select last pasted text
map("n", "gp", "`[v`]")

-- Semicolon for colon
map({ "n", "v" }, ";", ":")

-- Pane management
map("n", "<Leader><Space>", "<C-w><C-w>")
map("n", "<C-w>", "<C-w><C-w>")
map("t", "<C-w>", "<C-w><C-w>")
map("t", "<C-i>", "<C-w>N")

-- Faster saving and quitting
map("n", "<Enter>", ":w<CR>")
map("n", "W", ":w<CR>")
map("n", "X", ":x<CR>")
map("n", "Q", ":q<CR>")
map("n", "!", ":q!<CR>")
map("n", "q:", ":q")

-- Quick access to config
map("n", "<Leader>v", ":vsp ~/.config/nvim/init.lua<CR>")

-- Line ends and starts
map("n", "<Leader>h", "0")
map("n", "<Leader>l", "$")

-- Function keys
map({ "n", "v" }, "<F1>", ":setlocal spell!<CR>")
map("n", "<F2>", "ciw")
map("v", "<F2>", "c")
map("n", "<F6>", ":set paste<CR>o")
map("n", "<F8>", ":set nu!<CR>")

map("n", "<Leader>c", "ciw")

-- Custom commands
vim.api.nvim_create_user_command("W", "w", { nargs = "*" })

vim.api.nvim_create_user_command("TrimWhitespace", function()
    local save = vim.fn.winsaveview()
    vim.cmd([[ %s/\s\+$//e ]])
    vim.fn.winrestview(save)
end, {})

map("n", "<Leader><Backspace>", ":TrimWhitespace<CR>")

vim.api.nvim_create_user_command("Fixtab", function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.expandtab = true
    vim.cmd([[ retab | TrimWhitespace ]])
end, {})

vim.api.nvim_create_user_command("JSON", "%!python3 -m json.tool", {})


-- EvalPy (Simplified version of your crazy command)
vim.api.nvim_create_user_command("EvalPy", function()
  local line = vim.api.nvim_get_current_line()
  local cmd = string.format('python3 -c "from math import *; import requests; import json; print(%s)"', line)
  local output = vim.fn.system(cmd)
  vim.api.nvim_buf_set_lines(0, vim.fn.line("."), vim.fn.line("."), false, { output })
end, {})
