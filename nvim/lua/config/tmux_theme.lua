-- Make tmux's status bar match nvim's colorscheme while nvim has focus.
-- Uses bin/tmux-theme from the dotfiles; requires `focus-events on` in tmux.
if not vim.env.TMUX then
  return
end

local script = vim.fn.expand("~/.dotfiles/bin/tmux-theme")
if vim.fn.executable(script) == 0 then
  return
end

local function set(theme, sync)
  if sync then
    vim.fn.system({ script, theme }) -- must finish before nvim exits
  else
    vim.fn.jobstart({ script, theme }, { detach = true })
  end
end

local group = vim.api.nvim_create_augroup("TmuxTheme", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained", "VimResume" }, {
  group = group,
  callback = function() set("tokyonight") end,
})
vim.api.nvim_create_autocmd({ "FocusLost", "VimSuspend" }, {
  group = group,
  callback = function() set("solarized") end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = function() set("solarized", true) end,
})
