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
-- Next split; in tmux, the last split moves on to the next tmux pane (tmux.conf passes <C-w> to nvim).
-- nowait: Neovim's built-in <C-w>d / <C-w><C-d> would otherwise make this wait for timeoutlen
map("n", "<C-w>", function()
    if vim.env.TMUX and vim.fn.winnr() == vim.fn.winnr("$") then
        vim.cmd("1wincmd w") -- start from the first split when coming back
        vim.system({ "tmux", "select-pane", "-t", ":.+" })
    else
        vim.cmd("wincmd w")
    end
end, { nowait = true, desc = "Next split, then next tmux pane" })

-- Faster saving and quitting
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
map("n", "<F8>", ":set nu!<CR>")

map("n", "<Leader>c", "ciw")

-- Diagnostics
map("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
map("n", "<Leader>q", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })


-- Toggle comments (uses mini.comment's gcc/gc operators)
map("n", "<Leader>/", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<Leader>/", "gc", { remap = true, desc = "Toggle comment" })

-- Custom commands
vim.api.nvim_create_user_command("W", "w<bang> <args>", { nargs = "*", bang = true, complete = "file" })

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
