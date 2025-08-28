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

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
          always_divide_middle = true,
        },
        sections = {
          lualine_a = {
            {
              'mode',
              color = { fg = '#7dcfff', bg = '#1a1b26', gui = 'bold' }, -- more vibrant blue
              separator = { left = '', right = '' },
            }
          },
          lualine_b = {
            {
              'branch',
              icon = '',
              color = { fg = '#bb9af7', gui = 'bold' },
            },
            {
              'diff',
              symbols = { added = ' ', modified = ' ', removed = ' ' },
              color = { fg = '#e0af68' },
            },
            {
              macro_recording,
              color = { fg = '#ff007c', bg = '#1a1b26', gui = 'bold,italic' }, -- hot pink for macro
            }
          },
          lualine_c = {
            {
              'diagnostics',
              sources = { 'nvim_lsp' },
              symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
              color = { fg = '#e0af68' },
            },
            {
              'filename',
              path = 1,
              color = { fg = '#c0caf5', gui = 'bold' },
            }
          },
          lualine_x = {
            {
              'fileformat',
              icons_enabled = true,
              color = { fg = '#7dcfff' },
            },
            {
              'filetype',
              icon_only = true,
              color = { fg = '#ff9e64' },
            }
          },
          lualine_y = {
            {
              'progress',
              icon = '',
              color = { fg = '#f7768e', gui = 'bold' },
            }
          },
          lualine_z = {
            {
              'location',
              icon = '',
              color = { fg = '#1a1b26', gui = 'bold', bg = '#7aa2f7' },
              separator = { left = '', right = '' },
            }
          }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', separator = { left = '', right = '' } } },
          lualine_x = { { 'location', separator = { left = '', right = '' } } },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        extensions = { 'nvim-tree', 'toggleterm', 'quickfix' }
      }
      -- Fix signcolumn so line numbers never move
      vim.opt.signcolumn = "yes:2"
    end
  }
}
