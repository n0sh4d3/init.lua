return {
  'everviolet/nvim',
  name = 'evergarden',
  priority = 1000,
  config = function()
    require 'evergarden'.setup {
      theme = {
        variant = 'fall', -- 'winter'|'fall'|'spring'|'summer'
      },
      editor = {
        transparent_background = true,
        override_terminal = true,
        sign = { color = 'none' },
        float = {
        },
      },
      style = {
        tabline = { 'reverse' },
        search = { 'italic', 'reverse' },
        incsearch = { 'italic', 'reverse' },
        types = { 'italic' },
        keyword = { 'italic' },
        comment = { 'italic' },
      },
      overrides = {},
      color_overrides = {},
    }
    vim.cmd.colorscheme("evergarden")
  end
}
