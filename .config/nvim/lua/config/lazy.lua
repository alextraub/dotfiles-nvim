-- [[ Install `lazy.nvim` plugin manager ]]
--  See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--  Every file in lua/plugins/ returns a list of plugin specs. The useful spec keys:
--
--    opts = {}            passed to `require(<plugin>).setup(opts)`; specs for the same
--                         plugin in different files are deep-merged together
--    opts = function(_, opts) ... end   modify the merged opts instead of replacing them
--    opts_extend = { "a.b" }            lists at these paths are appended, not replaced
--    config = function(_, opts) ... end only when `setup(opts)` isn't enough
--    init = function() ... end          runs at startup, even if the plugin is lazy
--    event / cmd / ft / keys            load the plugin lazily on first use
--    dependencies = { ... }             load these first
--
--  `:Lazy` shows plugin status, `:Lazy update` updates them
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})
