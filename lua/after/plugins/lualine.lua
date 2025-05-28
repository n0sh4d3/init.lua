return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = ' ', right = ' ' },
          globalstatus = true,
          always_divide_middle = true,
        },
        sections = {
          lualine_a = {
            {
              'mode',
              icon = '',
              fmt = function(str)
                return '作戦 ' .. str
              end,
            }
          },
          lualine_b = {
            {
              'branch',
              icon = ''
            },
            {
              'diff',
              symbols = { added = '+', modified = '~', removed = '-' },
            },
          },
          lualine_y = {
            {
              'progress',
              icon = '進捗' -- "Progress"
            }
          },
          lualine_z = {
            {
              'location',
              icon = '座標' -- "Coordinates"
            }
          }
        },
        extensions = { 'nvim-tree', 'toggleterm', 'quickfix' }
      }
    end
  }
}
