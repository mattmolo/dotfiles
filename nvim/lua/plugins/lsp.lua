return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Buffer-local mappings on LSP attach.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition", buffer = ev.buf })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to References", buffer = ev.buf })
          vim.keymap.set("n", "<leader>d", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = ev.buf })
          vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code Action", buffer = ev.buf })
          vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename", buffer = ev.buf })
        end,
      })

      -- Apply cmp completion capabilities to every server (Neovim 0.11+ global config).
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Server-specific overrides (merged onto the "*" config above).
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- mason-lspconfig 2.0 installs these and auto-enables them via
      -- vim.lsp.enable(), using the vim.lsp.config() definitions above.
      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer",
          "gopls",
          "pyright",
          "ts_ls",
          "vue_ls",
          "lua_ls",
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
