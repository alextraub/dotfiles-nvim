-- Look and feel: colorscheme, statusline, icons, keymap hints
return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- load before other plugins so they pick up its colors
    opts = {
      transparent = true, -- let the terminal background show through
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {},
  },

  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      -- Serve mini.icons to plugins that expect nvim-web-devicons (lualine, telescope)
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Highlight TODO, NOTE, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
