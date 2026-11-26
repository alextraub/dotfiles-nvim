-- Formatting: `:lua require("conform").format()`, `:ConformInfo` (see `:help conform`)
--  Add formatters from any file:
--
--    { "stevearc/conform.nvim", opts = { formatters_by_ft = { lua = { "stylua" } } } }
return {
  { "stevearc/conform.nvim", cmd = "ConformInfo", opts = {} },
}
