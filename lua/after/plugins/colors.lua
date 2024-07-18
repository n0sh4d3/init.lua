return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        event = "VeryLazy",
        config = function()
            require('rose-pine').setup({
                disable_background = false,
                styles = {
                    italic = false,
                },
            })
        end,
        init = function()
            vim.cmd.colorscheme("rose-pine")
        end,
    },
    {
        "folke/tokyonight.nvim",
        event = "VeryLazy",
        config = function()
            require("tokyonight").setup({
                style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = false,    -- yeah i got better iterm background than plain color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false },
                    sidebars = "dark",      -- style for sidebars
                    floats = "transparent", -- style for floating windows
                },
                on_highlights = function(hl, c)
                    local bright_blue             = "#79C9F7"
                    hl.TelescopeNormal            = {
                        bg = c.bg_dark,
                        fg = white,
                    }
                    hl.TelescopeBorder            = {
                        bg = c.bg_dark,
                        fg = bright_blue,
                    }
                    hl.TelescopePromptNormal      = {
                        bg = c.bg_dark,
                        fg = white,
                    }
                    hl.TelescopePromptBorder      = {
                        bg = c.bg_dark,
                        fg = bright_blue,
                    }
                    hl.TelescopePromptTitle       = {
                        bg = c.bg_dark,
                        fg = bright_blue,
                    }
                    hl.TelescopePreviewTitle      = {
                        bg = c.bg_dark,
                        fg = bright_blue,
                    }
                    hl.TelescopeResultsTitle      = {
                        bg = c.bg_dark,
                        fg = bright_blue,
                    }
                    hl.GitSignsAdd                = { fg = "#a7da94" }
                    hl.GitSignsChange             = { fg = "#eed49f" }
                    hl.GitSignsDelete             = { fg = "#ec8696" }
                    hl.IndentBlanklineContextChar = {
                        fg = "#9d7cd8",
                        nocombine = true
                    }
                    hl.IblScope                   = {
                        fg = "#9d7cd8",
                        nocombine = true
                    }
                end,
            })
        end,
        init = function()
            -- vim.cmd.colorscheme("tokyonight")
        end
    },
}
