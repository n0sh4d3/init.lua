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


require("remaps.remaps")
require("settings")
require('gitsigns').setup()
require("nvim-highlight-colors").setup({})

require("bufferline").setup {
    options = {
        indicator_icon = "▎",
        modified_icon = "●",
        buffer_close_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 15,
        max_prefix_length = 6,
        diagnostics = "nvim_lsp",
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        persist_buffer_sort = true,
        enforce_regular_tabs = true,
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and "" or ""
            return icon .. count
        end,
    },
}
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
