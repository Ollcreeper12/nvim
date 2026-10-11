local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Get Lazy.nvim --

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end

-- Add Lazy To Runtime --
vim.opt.rtp:prepend(lazypath)

-- Init Pgk Mgr
require("lazy").setup({
  spec = {
    { import = "plugins.specs" },
  },
})

