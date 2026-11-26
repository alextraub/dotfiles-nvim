-- Language servers + completion. Each server is installed by Mason, then passed to `vim.lsp.config()`
-- and enabled (see `:help lsp-config`). Add a server from any file:
--
--   { "neovim/nvim-lspconfig", opts = { servers = { pyright = {} } } }
--
-- Keymaps are Neovim's defaults: `:help lsp-defaults`
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp", -- adds completion capabilities to every server
      { "j-hui/fidget.nvim", opts = {} }, -- LSP progress messages
    },
    opts = {
      servers = {
        lua_ls = {},
        rust_analyzer = {},
        pyright = {},
        wgsl_analyzer = {},
      },
    },
    config = function(_, opts)
      for name, server in pairs(opts.servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(opts.servers),
        automatic_enable = false, -- servers are enabled above
      })
    end,
  },

  -- Autocompletion menu: suggestions from LSP, paths, snippets, buffer words (see `:help blink-cmp`)
  --  Default keys: <c-y> accept, <c-space> menu/docs, <c-n>/<c-p> select, <c-e> hide
  {
    "saghen/blink.cmp",
    version = "1.*", -- release tags ship a prebuilt fuzzy matcher
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "2.*", build = "make install_jsregexp" },
      "folke/lazydev.nvim",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "lazydev" },
        providers = {
          lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
    },
    opts_extend = { "sources.default" },
  },

  -- Neovim API types/completion for lua_ls when editing your config
  { "folke/lazydev.nvim", ft = "lua", opts = {} },
}
