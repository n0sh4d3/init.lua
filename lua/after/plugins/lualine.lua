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
          return "󰑋 @" .. recording_register -- futuristic macro icon
        end
      end

      -- Gruber Darker palette
      local bg       = '#181818'
      local fg       = '#e4e4ef'
      local niagara  = '#96a6c8' -- blue
      local wisteria = '#9e95c7' -- magenta
      local quartz   = '#95a99f' -- cyan-ish
      local yellow   = '#ffdd33'
      local red      = '#f43841'
      local green    = '#73c936'
      local black    = '#000000'

      require('lualine').setup {
        options           = {
          icons_enabled        = true,
          theme                = 'auto',
          component_separators = { left = '', right = '' },
          section_separators   = { left = '', right = '' },
          globalstatus         = true,
          always_divide_middle = true,
        },
        sections          = {
          lualine_a = {
            {
              'mode',
              color = { fg = niagara, bg = bg, gui = 'bold' },
              separator = { left = '', right = '' },
            }
          },
          lualine_b = {
            {
              'branch',
              icon = '',
              color = { fg = wisteria, gui = 'bold' },
            },
            {
              'diff',
              symbols = { added = ' ', modified = ' ', removed = ' ' },
              -- use gruber accents: + green, ~ yellow, - red
              diff_color = {
                added    = { fg = green },
                modified = { fg = yellow },
                removed  = { fg = red },
              },
            },
            {
              macro_recording,
              color = { fg = wisteria, bg = bg, gui = 'bold,italic' },
            }
          },
          lualine_c = {
            {
              'diagnostics',
              sources = { 'nvim_lsp' },
              symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
              diagnostics_color = {
                error = { fg = red },
                warn  = { fg = yellow },
                info  = { fg = niagara },
                hint  = { fg = quartz },
              },
            },
            {
              'filename',
              path = 1,
              color = { fg = fg, gui = 'bold' },
            }
          },
          lualine_x = {
            {
              'fileformat',
              icons_enabled = true,
              color = { fg = quartz },
            },
            {
              'filetype',
              icon_only = true,
              color = { fg = yellow },
            }
          },
          lualine_y = {
            {
              'progress',
              icon = '',
              color = { fg = red, gui = 'bold' },
            }
          },
          lualine_z = {
            {
              'location',
              icon = '',
              color = { fg = bg, gui = 'bold', bg = niagara },
              separator = { left = '', right = '' },
            }
          }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', color = { fg = quartz }, separator = { left = '', right = '' } } },
          lualine_x = { { 'location', color = { fg = niagara }, separator = { left = '', right = '' } } },
          lualine_y = {},
          lualine_z = {}
        },
        tabline           = {},
        winbar            = {},
        extensions        = { 'nvim-tree', 'toggleterm', 'quickfix' }
      }

      -- Fix signcolumn so line numbers never move
      vim.opt.signcolumn = "yes:2"
    end
  }
}
