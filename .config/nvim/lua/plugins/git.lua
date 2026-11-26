-- Git signs in the gutter: `:Gitsigns` lists every action (see `:help gitsigns`)
return {
  { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
      { "<leader>gj", "<cmd>Git<cr>", desc = "Git Status" }, -- Alternative mirror to match LazyVim's default lazygit map
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
      { "<leader>gl", "<cmd>Git log<cr>", desc = "Git Log" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff Split" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    },
  },
}
