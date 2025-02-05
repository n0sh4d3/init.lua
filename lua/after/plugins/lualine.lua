return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '▐', right = '▌' },
                    section_separators = { left = '█', right = '█' },
                    always_divide_middle = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { { 'mode', color = { fg = '#FF003C', bg = '#000000', gui = 'bold' } } },
                    lualine_b = { { 'branch', icon = '', color = { fg = '#8A2BE2' } }, 'diff', 'diagnostics' },
                    lualine_c = { { 'filename', color = { fg = '#39FF14' } } },
                    lualine_x = { { 'encoding', color = { fg = '#FF4500' } }, 'fileformat', 'filetype' },
                    lualine_y = { { 'progress', color = { fg = '#EAEAEA' } } },
                    lualine_z = { { 'location', color = { fg = '#FF003C', gui = 'bold' } } }
                },
                inactive_sections = {
                    lualine_c = { { 'filename', color = { fg = '#4A4A4A' } } },
                    lualine_x = { { 'location', color = { fg = '#4A4A4A' } } }
                },
            }
        end
    },
}

