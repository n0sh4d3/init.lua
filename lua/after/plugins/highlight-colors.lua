return {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
        require("nvim-highlight-colors").setup({
            render = "background",
            virtual_symbol = "⬤",
            virtual_symbol_prefix = "",
        })
        vim.api.nvim_set_hl(0, "HighlightColorsVirtual", { fg = "#7dcfff", bg = "NONE", bold = true })
    end,
}
