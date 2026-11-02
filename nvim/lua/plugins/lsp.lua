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

      -- Only ask Mason for a server when the tool it needs is installed, so
      -- machines without e.g. go or node don't get install errors on startup.
      local servers_by_tool = {
        -- Mason builds gopls with `go install`
        go = { "gopls" },
        -- these are npm packages
        npm = { "pyright", "ts_ls", "vue_ls" },
        -- rust-analyzer is a prebuilt binary, but it can't do anything without cargo
        cargo = { "rust_analyzer" },
      }
      -- lua_ls is a prebuilt binary with no dependencies, and this config is lua
      local servers = { "lua_ls" }
      for tool, names in pairs(servers_by_tool) do
        if vim.fn.executable(tool) == 1 then
          vim.list_extend(servers, names)
        end
      end

      -- mason-lspconfig 2.0 installs these and auto-enables them via
      -- vim.lsp.enable(), using the vim.lsp.config() definitions above.
      require("mason-lspconfig").setup({
        ensure_installed = servers,
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
