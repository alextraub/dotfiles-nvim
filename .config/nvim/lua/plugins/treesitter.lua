-- Treesitter: highlighting and indentation from real parsers
--  Add parsers from any file (lists are appended):
--
--    { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "python" } } }
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "lua", "luadoc", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    },
    config = function(_, opts)
      require("nvim-treesitter").install(opts.ensure_installed)

      -- Start treesitter for any filetype that has an installed parser
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- Treesitter text object queries (@function, @class, ...), e.g. for mini.ai's `gen_spec.treesitter`
  { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main", lazy = true },
}
