-- NEUROTOXIN.nvim - Refined for usability & hacker aesthetics
local neurotoxin = {}

neurotoxin.palette = {
  background          = '#000000', -- Dark Void (softer black)
  foreground          = '#f4f4f4', -- Pale Gray (soft white)
  statement           = '#abdd64', -- Muted Red (for errors)
  strings             = '#c38890', -- Soothing Green (for strings)
  constants           = '#6d80fa', -- Warm Yellow (for constants)
  identifier          = '#f4f4f4', -- Hacker Blue (functions/keywords)
  special_identifiers = '#387080', -- Soft Purple (special identifiers)
  operatos            = '#8db7ff', -- Cool Cyan (for operators)
  comment             = '#566c86', -- Muted Gray (comments, subtle UI)
}

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.g.colors_name = 'neurotoxin'

-- Core Highlights
vim.api.nvim_set_hl(0, 'Normal', { fg = neurotoxin.palette.foreground, bg = neurotoxin.palette.background })
vim.api.nvim_set_hl(0, 'Comment', { fg = neurotoxin.palette.comment, italic = true })
vim.api.nvim_set_hl(0, 'Constant', { fg = neurotoxin.palette.constants })
vim.api.nvim_set_hl(0, 'String', { fg = neurotoxin.palette.strings })
vim.api.nvim_set_hl(0, 'Identifier', { fg = neurotoxin.palette.identifier })
vim.api.nvim_set_hl(0, 'Statement', { fg = neurotoxin.palette.statement, bold = true })
vim.api.nvim_set_hl(0, 'PreProc', { fg = neurotoxin.palette.special_identifiers })
vim.api.nvim_set_hl(0, 'Type', { fg = neurotoxin.palette.operatos, bold = true })
vim.api.nvim_set_hl(0, 'Special', { fg = neurotoxin.palette.special_identifiers })
vim.api.nvim_set_hl(0, 'Underlined', { fg = neurotoxin.palette.identifier, underline = true })

-- UI Elements
vim.api.nvim_set_hl(0, 'StatusLine', { fg = neurotoxin.palette.foreground, bg = '#161B22', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = neurotoxin.palette.comment, bg = '#161B22' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = neurotoxin.palette.comment })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = neurotoxin.palette.identifier, bold = true })
vim.api.nvim_set_hl(0, 'Visual', { bg = '#264F78' })

-- Diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = neurotoxin.palette.statement })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = neurotoxin.palette.constants })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = neurotoxin.palette.identifier })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = neurotoxin.palette.operatos })

-- Tree-sitter Highlights
vim.api.nvim_set_hl(0, '@comment', { fg = neurotoxin.palette.comment, italic = true })
vim.api.nvim_set_hl(0, '@constant', { fg = neurotoxin.palette.constants })
vim.api.nvim_set_hl(0, '@string', { fg = neurotoxin.palette.strings })
vim.api.nvim_set_hl(0, '@variable', { fg = neurotoxin.palette.foreground })
vim.api.nvim_set_hl(0, '@function', { fg = neurotoxin.palette.identifier, bold = true })
vim.api.nvim_set_hl(0, '@keyword', { fg = neurotoxin.palette.statement, bold = true })
vim.api.nvim_set_hl(0, '@type', { fg = neurotoxin.palette.operatos, bold = true })
vim.api.nvim_set_hl(0, '@operator', { fg = neurotoxin.palette.operatos })
vim.api.nvim_set_hl(0, '@number', { fg = neurotoxin.palette.constants })
vim.api.nvim_set_hl(0, '@boolean', { fg = neurotoxin.palette.statement })

return neurotoxin
