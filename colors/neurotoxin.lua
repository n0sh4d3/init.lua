-- NEUROTOXIN.nvim - Refined for usability & hacker aesthetics
local neurotoxin = {}

neurotoxin.palette = {
    bg     = '#000000', -- Dark Void (softer black)
    fg     = '#f4f4f4', -- Pale Gray (soft white)
    orange = '#abdd64', -- Muted Red (for errors)
    green  = '#aee2ff', -- Soothing Green (for strings)
    yellow = '#6d80fa', -- Warm Yellow (for constants)
    blue   = '#aee2ff', -- Hacker Blue (functions/keywords)
    purple = '#834dc4', -- Soft Purple (special identifiers)
    cyan   = '#8db7ff', -- Cool Cyan (for operators)
    gray   = '#566c86', -- Muted Gray (comments, subtle UI)
}

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
end
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.g.colors_name = 'neurotoxin'

-- Core Highlights
vim.api.nvim_set_hl(0, 'Normal', { fg = neurotoxin.palette.fg, bg = neurotoxin.palette.bg })
vim.api.nvim_set_hl(0, 'Comment', { fg = neurotoxin.palette.gray, italic = true })
vim.api.nvim_set_hl(0, 'Constant', { fg = neurotoxin.palette.yellow })
vim.api.nvim_set_hl(0, 'String', { fg = neurotoxin.palette.green })
vim.api.nvim_set_hl(0, 'Identifier', { fg = neurotoxin.palette.blue })
vim.api.nvim_set_hl(0, 'Statement', { fg = neurotoxin.palette.orange, bold = true })
vim.api.nvim_set_hl(0, 'PreProc', { fg = neurotoxin.palette.purple })
vim.api.nvim_set_hl(0, 'Type', { fg = neurotoxin.palette.cyan, bold = true })
vim.api.nvim_set_hl(0, 'Special', { fg = neurotoxin.palette.purple })
vim.api.nvim_set_hl(0, 'Underlined', { fg = neurotoxin.palette.blue, underline = true })

-- UI Elements
vim.api.nvim_set_hl(0, 'StatusLine', { fg = neurotoxin.palette.fg, bg = '#161B22', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = neurotoxin.palette.gray, bg = '#161B22' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = neurotoxin.palette.gray })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = neurotoxin.palette.blue, bold = true })
vim.api.nvim_set_hl(0, 'Visual', { bg = '#264F78' })

-- Diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = neurotoxin.palette.orange })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = neurotoxin.palette.yellow })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = neurotoxin.palette.blue })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = neurotoxin.palette.cyan })

-- Tree-sitter Highlights
vim.api.nvim_set_hl(0, '@comment', { fg = neurotoxin.palette.gray, italic = true })
vim.api.nvim_set_hl(0, '@constant', { fg = neurotoxin.palette.yellow })
vim.api.nvim_set_hl(0, '@string', { fg = neurotoxin.palette.green })
vim.api.nvim_set_hl(0, '@variable', { fg = neurotoxin.palette.fg })
vim.api.nvim_set_hl(0, '@function', { fg = neurotoxin.palette.blue, bold = true })
vim.api.nvim_set_hl(0, '@keyword', { fg = neurotoxin.palette.orange, bold = true })
vim.api.nvim_set_hl(0, '@type', { fg = neurotoxin.palette.cyan, bold = true })
vim.api.nvim_set_hl(0, '@operator', { fg = neurotoxin.palette.cyan })
vim.api.nvim_set_hl(0, '@number', { fg = neurotoxin.palette.yellow })
vim.api.nvim_set_hl(0, '@boolean', { fg = neurotoxin.palette.orange })

return neurotoxin
