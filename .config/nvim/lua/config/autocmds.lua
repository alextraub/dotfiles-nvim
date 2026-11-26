-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Keep the background transparent, even after switching colorschemes
vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Clear background highlights for a transparent background",
  group = vim.api.nvim_create_augroup("transparent-background", { clear = true }),
  callback = function()
    for _, group in ipairs({ "Normal", "NormalNC", "NormalFloat", "FloatBorder", "SignColumn", "EndOfBuffer" }) do
      vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = group }), { bg = "none" }))
    end
  end,
})
