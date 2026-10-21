-- Markdown reader view: reflow hard-wrapped paragraphs into a centered popup
-- (max 110 columns wide), so long lines don't leave ragged gaps.
-- Uses prettier (via npx) since it leaves code blocks and tables intact.

local MAX_WIDTH = 110

local function reflow()
  -- Re-running from the reader view reflows the original file again
  local src = vim.b.reflow_source or vim.api.nvim_get_current_buf()
  local width = math.min(MAX_WIDTH, vim.o.columns - 4)
  local height = vim.o.lines - 6
  local text = table.concat(vim.api.nvim_buf_get_lines(src, 0, -1, false), "\n")

  vim.notify("Reflowing...")
  vim.system({
    "npx", "--yes", "prettier",
    "--parser", "markdown",
    "--prose-wrap", "always",
    "--print-width", tostring(width - 1),
  }, { stdin = text, text = true }, vim.schedule_wrap(function(res)
    if res.code ~= 0 then
      vim.notify("Reflow failed: " .. res.stderr, vim.log.levels.ERROR)
      return
    end

    -- Replace an already open reader view
    if vim.b.reflow_source then
      vim.api.nvim_win_close(0, true)
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(res.stdout, "\n", { trimempty = true }))
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = "wipe"
    vim.b[buf].reflow_source = src

    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = math.floor((vim.o.lines - height) / 2) - 1,
      col = math.floor((vim.o.columns - width) / 2),
      border = "rounded",
      title = " " .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(src), ":t") .. " ",
      title_pos = "center",
    })
    -- Set after the filetype so the markdown autocmd doesn't override these
    vim.bo[buf].filetype = "markdown"
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false
    vim.wo[win].signcolumn = "no"
    vim.wo[win].colorcolumn = ""
    vim.wo[win].spell = false

    for _, key in ipairs({ "q", "<Esc>" }) do
      vim.keymap.set("n", key, function()
        vim.api.nvim_win_close(win, true)
      end, { buffer = buf, desc = "Close reader view" })
    end
  end))
end

vim.api.nvim_create_user_command("Reflow", reflow, { desc = "Markdown reader view" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(ev)
    vim.keymap.set("n", "<Leader>mr", reflow, { buffer = ev.buf, desc = "Markdown reader view" })
  end,
})
