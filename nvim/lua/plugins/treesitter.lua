return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- the main branch doesn't support lazy-loading
    build = ":TSUpdate",
    config = function()
      -- No-op for parsers that are already installed
      require("nvim-treesitter").install({
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "rust",
        "go",
      })

      -- The main branch has no `indent = { enable = true }`; opt in per buffer instead.
      -- Highlighting stays off (Neovim still starts it itself for lua, markdown, vimdoc, etc).
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_indent", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if lang and vim.treesitter.language.add(lang) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
