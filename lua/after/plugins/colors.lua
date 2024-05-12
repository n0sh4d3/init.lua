function ColorMyPencils(color)
    color = color
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "catppuccin/nvim",
        --        "Mofiqul/vscode.nvim", for memez
        event = "VeryLazy",
        enabled = false,
        init = function()
            --vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "folke/tokyonight.nvim",
        enabled = true,
        config = function()
            require("tokyonight").setup({
                style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true,     -- yeah i got better iterm background than plain color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = true },
                    keywords = { italic = false },
                    sidebars = "dark",      -- style for sidebars, see below
                    floats = "transparent", -- style for floating windows
                },
                on_highlights = function(hl, c)
                    local bright_blue        = "#79C9F7"
                    hl.TelescopeNormal       = {
                        bg = c.bg_dark,
                        fg = white,
                    }
                    hl.TelescopeBorder       = {
                        bg = c.bg_dark,
                        fg = bright_blue,
                    }
                    hl.TelescopePromptNormal = {
                        bg = c.bg_dark,
                        fg = white,
                    }
                    hl.TelescopePromptBorder = {
                        bg = c.bg_dark,
                        fg = bright_blue,
                    }
                    hl.TelescopePromptTitle  = {
                        bg = c.bg_dark,
                        fg = bright_blue,
                    }
                    hl.TelescopePreviewTitle = {
                        bg = c.bg_dark,
                        fg = bright_blue,
                    }
                    hl.TelescopeResultsTitle = {
                        bg = c.bg_dark,
                        fg = bright_blue,
                    }
                    hl.GitSignsAdd           = { fg = "#a7da94" }
                    hl.GitSignsChange        = { fg = "#eed49f" }
                    hl.GitSignsDelete        = { fg = "#ec8696" }
                end,
            })
        end,
        init = function()
            vim.cmd.colorscheme("tokyonight")
        end
    },
}


--ColorMyPencils()
