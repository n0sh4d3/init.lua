return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "BufEnter *.*",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = ' ', right = ' ' }, -- Glitch effect
                    section_separators = { left = '█▓▒░', right = '░▒▓█' }, -- Cyber grid
                    always_divide_middle = true,
                    globalstatus = true,
                },

                -- 🩸 ACTIVE SECTIONS: HACKER WARZONE 🩸
                sections = {
                    lualine_a = {
                        { 'mode',
                            color = { fg = '#FF003C', gui = 'bold' },
                            icon = '󰀘' -- POWER MODE
                        }
                    },
                    lualine_b = {
                        { 'branch', icon = '', color = { fg = '#8A2BE2' } }, -- Git Branch in War Mode
                        { 'diff', color = { fg = '#00FFFF' } }, -- Cyan diff stats
                        { 'diagnostics', color = { fg = '#FF4500' } } -- Red alert for errors
                    },
                    lualine_c = {
                        { 'filename', color = { fg = '#39FF14' }, icon = '' } -- Hacker green filenames
                    },
                    lualine_x = {
                        { 'encoding', color = { fg = '#FF4500' }, icon = '' }, -- Encoding as a hacked script
                    },
                    lualine_y = {
                        { 'progress', color = { fg = '#EAEAEA' }, icon = '󰖩' } -- Live system scan progress
                    },
                    lualine_z = {
                        { 'location', color = { fg = '#FF003C', gui = 'bold' }, icon = '󰁽' } -- Red alert location tracking
                    }
                },

                -- ☠️ INACTIVE SECTIONS: THE SYSTEM WAITS ☠️
                inactive_sections = {
                    lualine_c = { { 'filename', color = { fg = '#4A4A4A' }, icon = '󰈸' } }, -- Dark mode filename
                    lualine_x = { { 'location', color = { fg = '#4A4A4A' }, icon = '󰈸' } } -- Muted location
                },
            }
        end
    },
}
-- 🕶️ You are now running in ghost mode. No logs. No traces. 🕶️
