return {
  {
    'nvim-lualine/lualine.nvim',
    enabled = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Custom component for macro recording
      local function macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "Recording @" .. recording_register
        end
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
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
              color = { fg = '#f7768e', gui = 'bold' },
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
              icon = '', -- Remove Japanese icon
            }
          },
          lualine_z = {
            {
              'location',
              icon = '', -- Remove Japanese icon
            }
          }
        },
        extensions = { 'nvim-tree', 'toggleterm', 'quickfix' }
      }
    end
  }
}
