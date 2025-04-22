return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Get catppuccin mocha colors specifically
      local cp = require("catppuccin.palettes").get_palette("mocha")

      local colors = {
        sakura = cp.mauve,     -- Catppuccin Mocha's mauve (lavender/pinkish purple)
        indigo = cp.blue,      -- Catppuccin Mocha's blue
        matcha = cp.green,     -- Catppuccin Mocha's green
        ocean = cp.teal,       -- Catppuccin Mocha's teal
        sunset = cp.peach,     -- Catppuccin Mocha's peach for sunset glow
        charcoal = cp.surface1 -- Catppuccin Mocha's darker tone for contrast
      }

      -- Function to check if a macro is being recorded
      local function is_macro_recording()
        return vim.fn.reg_recording() ~= ''
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'catppuccin', -- Using catppuccin theme
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
            },
            -- Macro recording indicator
            {
              function()
                return is_macro_recording() and 'Rec' or '' -- Display "Rec" if macro is being recorded
              end,
              color = { fg = cp.red, bg = colors.charcoal, gui = 'bold' },
              separator = '|'
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
                error = { fg = cp.red },
                warn = { fg = cp.yellow },
                info = { fg = cp.teal },
                hint = { fg = cp.green },
              }
            },
          },
          lualine_c = {
            {
              'filename',
              path = 1,
              symbols = {
                modified = ' *',
                readonly = ' *',
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

      -- Optional: Define special highlights to better integrate with Catppuccin Mocha specifically
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Re-apply custom highlights whenever the colorscheme changes
          local mocha = require("catppuccin.palettes").get_palette("mocha")
          vim.api.nvim_set_hl(0, "LualineMode", { fg = mocha.surface1, bg = mocha.mauve, bold = true })
          vim.api.nvim_set_hl(0, "LualineBranch", { fg = mocha.blue, bg = mocha.base })
          vim.api.nvim_set_hl(0, "LualineFilename", { fg = mocha.text, bg = mocha.base })
        end,
      })
    end
  }
}
