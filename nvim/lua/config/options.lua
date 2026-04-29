local opt = vim.opt

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
-- Let Neovim use its default undodir (~/.local/state/nvim/undo)
-- to prevent incompatible undo format conflicts with Vim.

opt.timeoutlen = 1000
-- Let Neovim handle ttimeoutlen automatically (default is 50)
-- to prevent terminal escape sequences from bleeding into the editor.

-- Theme/Colors
opt.termguicolors = true
opt.background = "dark"

-- UI
opt.number = true
opt.cursorline = true
opt.wildmenu = true
opt.wildignore = "*.o,*~"
opt.laststatus = 2
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.ruler = true
opt.showmatch = true
opt.matchtime = 1
opt.splitbelow = true
opt.splitright = true
opt.foldmethod = "manual"
opt.scrolloff = 5
opt.showcmd = true
opt.sidescroll = 3
opt.colorcolumn = "111"
opt.lazyredraw = false

-- Formatting
opt.wrap = false
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.shiftround = true
opt.autoindent = true
opt.cindent = true
opt.smarttab = true
opt.linebreak = true
opt.encoding = "utf-8"
opt.fileformat = "unix"

-- List characters
opt.list = true
opt.listchars = { tab = "|·", trail = "·", nbsp = "+" }

-- Help windows in vertical split
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("vimrc_help", { clear = true }),
  pattern = "*.txt",
  callback = function()
    if vim.bo.buftype == "help" then
      vim.cmd("wincmd L")
    end
  end,
})

-- Return to last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- FileType specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "make" },
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end,
})
