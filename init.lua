vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require("remaps.remaps")       -- my cute remaps
require("lazy-settings")       -- lazy settings to make it run faster and get custom ui
require("display-settings")    -- options for nvim
require("after.plugins")       -- plugins
require("mason").setup()       -- mason wasn't working without this thing
require('lspconfig')           -- idk wby but lsp sometimes doesn't work without it

require('ma_plugz.auto-pairz') -- me did auto-pairs plugin cuz those from github didn't work
