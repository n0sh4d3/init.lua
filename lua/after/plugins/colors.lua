function ColorMyPencils(color)
    color = color
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "catppuccin/nvim",
        --        "Mofiqul/vscode.nvim",
        event = "VeryLazy",
        init = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}


--ColorMyPencils()
