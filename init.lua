vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    { import = "after.plugins" },
}, {})


local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-h>", function()
    ui.nav_file(1)
end)
vim.keymap.set("n", "<C-t>", function()
    ui.nav_file(2)
end)
vim.keymap.set("n", "<C-n>", function()
    ui.nav_file(3)
end)
vim.keymap.set("n", "<C-s>", function()
    ui.nav_file(4)
end)

require("bufferline").setup {}
require("remaps.remaps")
require("settings")
require('gitsigns').setup()
require("nvim-highlight-colors").setup({})
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    --   filters = {
    --        dotfiles = true,
    --    },
})
