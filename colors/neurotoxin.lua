-- neurotoxin-base16 (tokyonight-storm vibes, neutral-ish whites)
local M = {}

-- Base16 slots
-- 00-07: core (bg..fg), 08-0F: accents
local base16 = {
  base00 = "#24283b", -- bg (storm base)
  base01 = "#1f2335", -- darker bg
  base02 = "#2f3549", -- selection/cursorline
  base03 = "#545c7e", -- comments/dim
  base04 = "#b7bdd6", -- subtle fg (less blue than stock)
  base05 = "#d7d8e4", -- main fg (neutralized “white”)
  base06 = "#e6e6ef", -- bright fg
  base07 = "#f2f2f5", -- near-white

  base08 = "#f7768e", -- red
  base09 = "#ff9e64", -- orange
  base0A = "#e0af68", -- yellow
  base0B = "#9ece6a", -- green
  base0C = "#73daca", -- cyan/teal
  base0D = "#7aa2f7", -- blue
  base0E = "#bb9af7", -- purple
  base0F = "#c68a75", -- brown/aux
}

-- convenience aliases
local c = base16

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "neurotoxin-base16"

local function hi(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- Core
hi("Normal", { fg = c.base05, bg = c.base00 })
hi("Comment", { fg = c.base03, italic = true })
hi("Constant", { fg = c.base0A }) -- lean warmer than stock tokyo
hi("String", { fg = c.base0B })
hi("Character", { fg = c.base0B })
hi("Identifier", { fg = c.base05 })
hi("Statement", { fg = c.base0D })
hi("PreProc", { fg = c.base0E })
hi("Type", { fg = c.base0E })
hi("Special", { fg = c.base0D })
hi("Underlined", { fg = c.base0D, underline = true })
hi("Error", { fg = c.base08 })
hi("Todo", { fg = c.base00, bg = c.base09 })

-- UI
hi("StatusLine", { fg = c.base05, bg = c.base02 })
hi("StatusLineNC", { fg = c.base03, bg = c.base02 })
hi("VertSplit", { fg = c.base02, bg = c.base00 })
hi("TabLine", { fg = c.base03, bg = c.base02 })
hi("TabLineFill", { fg = c.base05, bg = c.base00 })
hi("TabLineSel", { fg = c.base05, bg = c.base00 })
hi("Title", { fg = c.base0D })
hi("LineNr", { fg = c.base03 })
hi("CursorLineNr", { fg = c.base05 })
hi("CursorLine", { bg = c.base02 })
hi("ColorColumn", { bg = c.base02 })
hi("SignColumn", { bg = c.base00 })
hi("Visual", { bg = c.base02 })
hi("VisualNOS", { bg = c.base02 })
hi("Pmenu", { fg = c.base05, bg = c.base02 })
hi("PmenuSel", { fg = c.base07, bg = c.base0D })
hi("PmenuSbar", { bg = c.base02 })
hi("PmenuThumb", { bg = c.base03 })
hi("WildMenu", { fg = c.base07, bg = c.base0D })
hi("Folded", { fg = c.base03, bg = c.base02, italic = true })
hi("FoldColumn", { fg = c.base03, bg = c.base00 })
hi("SpecialKey", { fg = c.base0D })
hi("NonText", { fg = c.base03 })
hi("MatchParen", { fg = c.base07, bg = c.base03 })
hi("Conceal", { fg = c.base03 })
hi("Directory", { fg = c.base0D })
hi("Search", { fg = c.base00, bg = c.base0A })
hi("IncSearch", { fg = c.base00, bg = c.base0D })

-- Diagnostics (LSP)
hi("DiagnosticError", { fg = c.base08 })
hi("DiagnosticWarn", { fg = c.base09 })
hi("DiagnosticInfo", { fg = c.base0D })
hi("DiagnosticHint", { fg = c.base0C })
hi("DiagnosticUnderlineError", { sp = c.base08, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.base09, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = c.base0D, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = c.base0C, undercurl = true })

-- Treesitter
hi("@comment", { link = "Comment" })
hi("@constant", { fg = c.base0A })
hi("@constant.builtin", { fg = c.base0A })
hi("@string", { link = "String" })
hi("@variable", { fg = c.base05 })
hi("@function", { fg = c.base05 })
hi("@function.builtin", { fg = c.base0E })
hi("@function.macro", { fg = c.base0E })
hi("@keyword", { fg = c.base0D })
hi("@keyword.function", { fg = c.base0D })
hi("@keyword.operator", { fg = c.base0D })
hi("@keyword.return", { fg = c.base0D })
hi("@type", { fg = c.base0E })
hi("@type.builtin", { fg = c.base0E })
hi("@operator", { fg = c.base0D })
hi("@number", { fg = c.base09 }) -- numbers pop a tad warmer
hi("@boolean", { fg = c.base09 })
hi("@property", { fg = c.base05 })
hi("@punctuation.delimiter", { fg = c.base0D })
hi("@punctuation.bracket", { fg = c.base0D })
hi("@tag", { fg = c.base0D })
hi("@tag.attribute", { fg = c.base05 })
hi("@text", { fg = c.base05 })

-- Optional: export palette if you want to reuse it
M.palette = base16
return M
