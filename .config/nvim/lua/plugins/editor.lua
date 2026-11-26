-- Text editing: pairs, text objects, surroundings, comments
return {
  { "nvim-mini/mini.pairs", event = "VeryLazy", opts = {} },

  -- Around/inside text objects, e.g. `va)`, `ci'`, `yaf` (see `:help mini.ai`)
  { "nvim-mini/mini.ai", event = "VeryLazy", opts = {} },

  -- Surround actions: `sa` add, `sd` delete, `sr` replace (see `:help mini.surround`)
  { "nvim-mini/mini.surround", event = "VeryLazy", opts = {} },

  -- Better comment strings for `gc` in embedded languages (tsx, vue, ...)
  { "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },

  -- Automatically add closing tags for HTML and JSX
  { "windwp/nvim-ts-autotag", event = { "BufReadPost", "BufNewFile" }, opts = { } },

  -- Oil.nvim
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      use_default_keymaps = true,
    },
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
      { '-', '<CMD>Oil<CR>', mode = 'n', desc = 'Toggle Oil.nvim' }
    }
  },
}
