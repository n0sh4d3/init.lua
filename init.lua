vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    {
        import = "after.plugins",
    },
}, {})


require("remaps.remaps")
require("settings")


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single"
})
local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})
cmp.setup({
    view = {
        entries = "wildcard",
    },
})
