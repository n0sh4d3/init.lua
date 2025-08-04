return {
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Custom component for macro recording
      local function macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "記録中 @" .. recording_register -- "Recording @" in Japanese
        end
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '|', right = '|' },
          section_separators = { right = '', left = '' },
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
            -- Add macro recording indicator here
            {
              macro_recording,
              color = { fg = '#f7768e', gui = 'bold' }, -- Tokyo Night red, bold text
            }
          },
          lualine_c = {
            'filename'
          },
          lualine_x = {
            'encoding',
            'fileformat',
            'filetype'
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
