local M = {}

-- Gruber Darker color palette (exact match)
local colors = {
  -- Background colors
  bg = "#181818",       -- main background
  bg_dark = "#101010",  -- darker background
  bg_light = "#282828", -- lighter background (selection, etc)

  -- Foreground colors
  fg = "#e4e4ef",       -- main foreground
  fg_light = "#f4f4ff", -- lighter foreground
  fg_dim = "#52494e",   -- dimmed text

  -- Core colors (original Gruber Darker)
  red = "#f43841",    -- red
  orange = "#c73c3f", -- orange/brown
  yellow = "#ffdd33", -- original yellow (will be replaced for keywords only)
  green = "#73c936",  -- green
  blue = "#96a6c8",   -- blue/purple
  purple = "#9e95c7", -- purple

  -- Tokyo Night signature blue (replacement for yellow keywords)
  tokyo_blue = "#7aa2f7",

  -- Neutral colors
  white = "#ffffff",
  gray = "#cc8c3c",
  dark_gray = "#484848",
}

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "gruber-darker-tokyo"

local function hi(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- Core syntax highlighting (keywords get Tokyo blue, everything else stays gruber)
hi("Normal", { fg = colors.fg, bg = colors.bg })
hi("Comment", { fg = colors.fg_dim, italic = true })
hi("Constant", { fg = colors.blue })
hi("String", { fg = colors.green })
hi("Character", { fg = colors.green })
hi("Number", { fg = colors.purple })
hi("Boolean", { fg = colors.purple })
hi("Float", { fg = colors.purple })
hi("Identifier", { fg = colors.fg })
hi("Function", { fg = colors.blue })

-- KEYWORDS get Tokyo Night blue instead of yellow
hi("Statement", { fg = colors.tokyo_blue, bold = true })
hi("Conditional", { fg = colors.tokyo_blue, bold = true })
hi("Repeat", { fg = colors.tokyo_blue, bold = true })
hi("Label", { fg = colors.tokyo_blue, bold = true })
hi("Operator", { fg = colors.tokyo_blue })
hi("Keyword", { fg = colors.tokyo_blue, bold = true })
hi("Exception", { fg = colors.tokyo_blue, bold = true })

hi("PreProc", { fg = colors.blue })
hi("Include", { fg = colors.blue })
hi("Define", { fg = colors.blue })
hi("Macro", { fg = colors.blue })
hi("PreCondit", { fg = colors.blue })
hi("Type", { fg = colors.blue })
hi("StorageClass", { fg = colors.blue })
hi("Structure", { fg = colors.blue })
hi("Typedef", { fg = colors.blue })
hi("Special", { fg = colors.red })
hi("SpecialChar", { fg = colors.red })
hi("Tag", { fg = colors.red })
hi("Delimiter", { fg = colors.fg })
hi("SpecialComment", { fg = colors.fg_dim })
hi("Debug", { fg = colors.red })
hi("Underlined", { fg = colors.blue, underline = true })
hi("Error", { fg = colors.red })
hi("Todo", { fg = colors.yellow, bg = colors.bg_dark, bold = true })

-- UI Elements (exact Gruber Darker style)
hi("Cursor", { fg = colors.bg, bg = colors.fg })
hi("CursorLine", { bg = colors.bg_light })
hi("CursorColumn", { bg = colors.bg_light })
hi("ColorColumn", { bg = colors.bg_light })
hi("LineNr", { fg = colors.dark_gray })
hi("CursorLineNr", { fg = colors.fg, bold = true })
hi("VertSplit", { fg = colors.dark_gray, bg = colors.bg })
hi("MatchParen", { fg = colors.white, bg = colors.dark_gray, bold = true })
hi("StatusLine", { fg = colors.fg, bg = colors.bg_light })
hi("StatusLineNC", { fg = colors.fg_dim, bg = colors.bg_light })
hi("Pmenu", { fg = colors.fg, bg = colors.bg_light })
hi("PmenuSel", { fg = colors.bg, bg = colors.blue })
hi("PmenuSbar", { bg = colors.dark_gray })
hi("PmenuThumb", { bg = colors.fg_dim })
hi("TabLine", { fg = colors.fg_dim, bg = colors.bg_light })
hi("TabLineSel", { fg = colors.fg, bg = colors.bg, bold = true })
hi("TabLineFill", { fg = colors.fg_dim, bg = colors.bg_light })
hi("Title", { fg = colors.blue, bold = true })
hi("Visual", { bg = colors.bg_light })
hi("Search", { fg = colors.bg, bg = colors.yellow })
hi("IncSearch", { fg = colors.bg, bg = colors.orange })
hi("WildMenu", { fg = colors.bg, bg = colors.blue })
hi("Folded", { fg = colors.fg_dim, bg = colors.bg_light })
hi("FoldColumn", { fg = colors.fg_dim, bg = colors.bg })
hi("SignColumn", { fg = colors.fg_dim, bg = colors.bg })
hi("Directory", { fg = colors.blue })
hi("SpecialKey", { fg = colors.fg_dim })
hi("NonText", { fg = colors.fg_dim })
hi("ModeMsg", { fg = colors.green })
hi("MoreMsg", { fg = colors.green })
hi("Question", { fg = colors.green })
hi("WarningMsg", { fg = colors.orange })
hi("ErrorMsg", { fg = colors.red })

-- Treesitter (keywords get Tokyo blue, rest stays gruber)
hi("@comment", { link = "Comment" })
hi("@constant", { fg = colors.blue })
hi("@constant.builtin", { fg = colors.purple })
hi("@string", { fg = colors.green })
hi("@string.escape", { fg = colors.red })
hi("@character", { fg = colors.green })
hi("@number", { fg = colors.purple })
hi("@boolean", { fg = colors.purple })
hi("@float", { fg = colors.purple })
hi("@function", { fg = colors.blue })
hi("@function.builtin", { fg = colors.blue })
hi("@function.macro", { fg = colors.blue })
hi("@parameter", { fg = colors.fg })
hi("@method", { fg = colors.blue })
hi("@field", { fg = colors.fg })
hi("@property", { fg = colors.fg })
hi("@constructor", { fg = colors.blue })
hi("@conditional", { fg = colors.tokyo_blue, bold = true })
hi("@repeat", { fg = colors.tokyo_blue, bold = true })
hi("@label", { fg = colors.tokyo_blue })
hi("@operator", { fg = colors.tokyo_blue })
hi("@keyword", { fg = colors.tokyo_blue, bold = true })
hi("@exception", { fg = colors.tokyo_blue, bold = true })
hi("@keyword.function", { fg = colors.tokyo_blue, bold = true })
hi("@keyword.operator", { fg = colors.tokyo_blue })
hi("@keyword.return", { fg = colors.tokyo_blue, bold = true })
hi("@type", { fg = colors.blue })
hi("@type.builtin", { fg = colors.blue })
hi("@include", { fg = colors.blue })
hi("@variable", { fg = colors.fg })
hi("@variable.builtin", { fg = colors.blue })
hi("@text", { fg = colors.fg })
hi("@text.strong", { bold = true })
hi("@text.emphasis", { italic = true })
hi("@text.underline", { underline = true })
hi("@text.title", { fg = colors.blue, bold = true })
hi("@text.uri", { fg = colors.blue, underline = true })
hi("@tag", { fg = colors.red })
hi("@tag.attribute", { fg = colors.blue })
hi("@punctuation", { fg = colors.fg })
hi("@punctuation.bracket", { fg = colors.fg })
hi("@punctuation.delimiter", { fg = colors.fg })

-- LSP Diagnostics
hi("DiagnosticError", { fg = colors.red })
hi("DiagnosticWarn", { fg = colors.orange })
hi("DiagnosticInfo", { fg = colors.blue })
hi("DiagnosticHint", { fg = colors.green })
hi("DiagnosticUnderlineError", { sp = colors.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = colors.orange, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = colors.blue, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = colors.green, undercurl = true })

-- Git signs
hi("GitSignsAdd", { fg = colors.green })
hi("GitSignsChange", { fg = colors.blue })
hi("GitSignsDelete", { fg = colors.red })

-- Export palette
M.palette = colors
return M
