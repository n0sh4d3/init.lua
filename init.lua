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
require('gitsigns').setup()
require("nvim-highlight-colors").setup({})

require("bufferline").setup {
    options = {
        indicator_icon = "▎",
        modified_icon = "◉",
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
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single"
})
local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})
cmp.setup({
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                buffer = "[Buffer]",
            })[entry.source.name]

            return vim_item
        end,
    },
    view = {

        entries = "custom",
    }
})
