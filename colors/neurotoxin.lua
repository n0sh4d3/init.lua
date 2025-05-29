local neurotoxin = {}
neurotoxin.palette = {
  background       = '#151515',
  foreground       = '#d5d3d9', -- Lighter desaturated gray
  statement        = '#8c949e', -- Lighter muted blue-gray
  strings          = '#707867', -- Lighter faded olive
  constants        = '#6b8289', -- Lighter desaturated teal
  identifier       = '#b0b0b0', -- Lighter neutral gray
  special          = '#607386', -- Lighter muted slate blue
  operators        = '#858585', -- Lighter medium gray
  comment          = '#516070', -- Lighter dark gray (more visible)
  subtle_highlight = '#1e2630', -- Lighter subtle highlight
  error            = '#785258', -- Lighter desaturated dark red
  warning          = '#736859', -- Lighter desaturated dark amber
  info             = '#53667a', -- Lighter dark steel blue
  hint             = '#51604f', -- Lighter dark sage
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
vim.api.nvim_set_hl(0, 'Character', { fg = neurotoxin.palette.strings })
vim.api.nvim_set_hl(0, 'Identifier', { fg = neurotoxin.palette.identifier })
vim.api.nvim_set_hl(0, 'Statement', { fg = neurotoxin.palette.statement })
vim.api.nvim_set_hl(0, 'PreProc', { fg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, 'Type', { fg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, 'Special', { fg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, 'Underlined', { fg = neurotoxin.palette.identifier, underline = true })
vim.api.nvim_set_hl(0, 'Error', { fg = neurotoxin.palette.error })
vim.api.nvim_set_hl(0, 'Todo', { fg = neurotoxin.palette.background, bg = neurotoxin.palette.comment })

-- UI Elements
vim.api.nvim_set_hl(0, 'StatusLine', { fg = neurotoxin.palette.foreground, bg = neurotoxin.palette.subtle_highlight })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = neurotoxin.palette.comment, bg = neurotoxin.palette.subtle_highlight })
vim.api.nvim_set_hl(0, 'VertSplit', { fg = neurotoxin.palette.subtle_highlight, bg = neurotoxin.palette.background })
vim.api.nvim_set_hl(0, 'TabLine', { fg = neurotoxin.palette.comment, bg = neurotoxin.palette.subtle_highlight })
vim.api.nvim_set_hl(0, 'TabLineFill', { fg = neurotoxin.palette.foreground, bg = neurotoxin.palette.background })
vim.api.nvim_set_hl(0, 'TabLineSel', { fg = neurotoxin.palette.foreground, bg = neurotoxin.palette.background })

vim.api.nvim_set_hl(0, 'Title', { fg = neurotoxin.palette.statement })
vim.api.nvim_set_hl(0, 'LineNr', { fg = neurotoxin.palette.comment })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = neurotoxin.palette.foreground })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = neurotoxin.palette.subtle_highlight })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = neurotoxin.palette.subtle_highlight })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = neurotoxin.palette.background })
vim.api.nvim_set_hl(0, 'Visual', { bg = neurotoxin.palette.subtle_highlight })
vim.api.nvim_set_hl(0, 'VisualNOS', { bg = neurotoxin.palette.subtle_highlight })
vim.api.nvim_set_hl(0, 'Pmenu', { fg = neurotoxin.palette.foreground, bg = neurotoxin.palette.subtle_highlight })
vim.api.nvim_set_hl(0, 'PmenuSel', { fg = neurotoxin.palette.foreground, bg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = neurotoxin.palette.subtle_highlight })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = neurotoxin.palette.comment })
vim.api.nvim_set_hl(0, 'WildMenu', { fg = neurotoxin.palette.foreground, bg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, 'Folded',
  { fg = neurotoxin.palette.comment, bg = neurotoxin.palette.subtle_highlight, italic = true })
vim.api.nvim_set_hl(0, 'FoldColumn', { fg = neurotoxin.palette.comment, bg = neurotoxin.palette.background })

vim.api.nvim_set_hl(0, 'SpecialKey', { fg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, 'NonText', { fg = neurotoxin.palette.comment })
vim.api.nvim_set_hl(0, 'MatchParen', { fg = neurotoxin.palette.foreground, bg = neurotoxin.palette.comment })
vim.api.nvim_set_hl(0, 'Conceal', { fg = neurotoxin.palette.comment })
vim.api.nvim_set_hl(0, 'Directory', { fg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, 'Search', { fg = neurotoxin.palette.background, bg = neurotoxin.palette.constants })
vim.api.nvim_set_hl(0, 'IncSearch', { fg = neurotoxin.palette.background, bg = neurotoxin.palette.special })

-- Diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = neurotoxin.palette.error })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = neurotoxin.palette.warning })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = neurotoxin.palette.info })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = neurotoxin.palette.hint })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { sp = neurotoxin.palette.error, undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { sp = neurotoxin.palette.warning, undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { sp = neurotoxin.palette.info, undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { sp = neurotoxin.palette.hint, undercurl = true })

-- Tree-sitter Highlights
vim.api.nvim_set_hl(0, '@comment', { link = 'Comment' })
vim.api.nvim_set_hl(0, '@constant', { link = 'Constant' })
vim.api.nvim_set_hl(0, '@constant.builtin', { fg = neurotoxin.palette.constants })
vim.api.nvim_set_hl(0, '@string', { link = 'String' })
vim.api.nvim_set_hl(0, '@variable', { fg = neurotoxin.palette.foreground })
vim.api.nvim_set_hl(0, '@function', { fg = neurotoxin.palette.identifier })
vim.api.nvim_set_hl(0, '@function.builtin', { fg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, '@function.macro', { fg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, '@keyword', { fg = neurotoxin.palette.statement })
vim.api.nvim_set_hl(0, '@keyword.function', { fg = neurotoxin.palette.statement })
vim.api.nvim_set_hl(0, '@keyword.operator', { fg = neurotoxin.palette.operators })
vim.api.nvim_set_hl(0, '@keyword.return', { fg = neurotoxin.palette.statement })
vim.api.nvim_set_hl(0, '@type', { fg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, '@type.builtin', { fg = neurotoxin.palette.special })
vim.api.nvim_set_hl(0, '@operator', { fg = neurotoxin.palette.operators })
vim.api.nvim_set_hl(0, '@number', { fg = neurotoxin.palette.constants })
vim.api.nvim_set_hl(0, '@boolean', { fg = neurotoxin.palette.constants })
vim.api.nvim_set_hl(0, '@property', { fg = neurotoxin.palette.identifier })
vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = neurotoxin.palette.operators })
vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = neurotoxin.palette.operators })
vim.api.nvim_set_hl(0, '@tag', { fg = neurotoxin.palette.statement })
vim.api.nvim_set_hl(0, '@tag.attribute', { fg = neurotoxin.palette.identifier })
vim.api.nvim_set_hl(0, '@text', { fg = neurotoxin.palette.foreground })

return neurotoxin
