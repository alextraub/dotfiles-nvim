-- Fuzzy finding: `:Telescope` lists every picker (see `:help telescope.builtin`)
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-mini/mini.icons",
    },
    opts = {},
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end,
  },

  -- Use telescope for `vim.ui.select` (e.g. code action menus)
  {
    "nvim-telescope/telescope-ui-select.nvim",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("telescope").load_extension("ui-select")
        return vim.ui.select(...)
      end
    end,
  },
}
