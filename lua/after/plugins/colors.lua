return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        enabled = false,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = {     -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false, -- disables setting the background color.
                show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
                term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
                dim_inactive = {
                    enabled = false,            -- dims the background color of inactive window
                    shade = "dark",
                    percentage = 0.15,          -- percentage of the shade to apply to the inactive window
                },
                no_italic = false,              -- Force no italic
                no_bold = false,                -- Force no bold
                no_underline = false,           -- Force no underline
                styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" },    -- Change the style of comments
                    conditionals = {},
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                    -- miscs = {}, -- Uncomment to turn off hard-coded styles
                },
                color_overrides = {},
                custom_highlights = {},
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })

            -- vim.cmd.colorscheme "catppuccin"
        end
    },
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
