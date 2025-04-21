return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local colors = {
        sakura = "#FFB7C5",
        indigo = "#6E76B4",
        matcha = "#7CFC00",
        ocean = "#5DADE2",
        sunset = "#FF7E5F",
        charcoal = "#36454F"
      }

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
                return '作戦: ' .. str -- "Mission: Insert"
              end,
              color = { fg = colors.charcoal, bg = colors.sakura, gui = 'bold' }
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
              diff_color = {
                added = { fg = colors.matcha },
                modified = { fg = colors.ocean },
                removed = { fg = colors.sunset },
              }
            },
            {
              'diagnostics',
              symbols = {
                error = 'エラー', -- "Error"
                warn  = '警告', -- "Warning"
                info  = '情報', -- "Info"
                hint  = 'ヒント' -- "Hint"
              },
              diagnostics_color = {
                error = { fg = "#FF0000" },
                warn = { fg = "#FFFF00" },
                info = { fg = "#00FFFF" },
                hint = { fg = "#00FF00" },
              }
            },
          },
          lualine_c = {
            {
              'filename',
              path = 1,
              symbols = {
                modified = ' ✎',
                readonly = ' 🔒',
                unnamed = '[無名]' -- "Unnamed"
              }
            }
          },
          lualine_x = {
            { 'encoding' },
            { 'fileformat' },
            {
              'filetype',
              icon_only = true
            }
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
        tabline = {
          lualine_a = {
            {
              'tabs',
              mode = 2,
              fmt = function(name)
                return 'タブ: ' .. name -- "Tab: <name>"
              end
            }
          },
          lualine_z = {
            {
              function()
                return '時刻: ' .. os.date("%H:%M") -- "Time"
              end
            }
          }
        },
        extensions = { 'nvim-tree', 'toggleterm', 'quickfix' }
      }
    end
  }
}
