vim.opt.termguicolors = true
vim.opt.lazyredraw = true
vim.opt.ttyfast = true
vim.g.have_nerd_font = true
vim.opt.guicursor = "n-v-c:block"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.hlsearch = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes:2"
vim.opt.updatetime = 10
vim.opt.colorcolumn = "80"
vim.opt.shortmess:append("sI")
vim.opt.pumblend = 0
vim.opt.winblend = 0

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded", -- modern border
})


-- Netrw styling to match your telescope/floating window theme
vim.g.netrw_banner = 0       -- hide banner
vim.g.netrw_liststyle = 3    -- tree view
vim.g.netrw_browse_split = 0 -- open in same window
vim.g.netrw_winsize = 30     -- 30% width when splitting
vim.g.netrw_altv = 1         -- open splits to the right
vim.g.netrw_preview = 1      -- open previews vertically

-- Style netrw to match your telescope colors
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()

		-- Get your floating window bg color (same logic as telescope config)
		local function hl(name) return vim.api.nvim_get_hl(0, { name = name, link = false }) or {} end
		local normal = hl("Normal")
		local nf_bg = hl("NormalFloat").bg or tonumber("0x1f2335")
		local panel_hex = ("#%06x"):format(nf_bg)

		-- Apply telescope-like colors to netrw
		vim.api.nvim_set_hl(0, "netrwDir", { fg = "#7aa2f7", bold = true }) -- directories (blue)
		vim.api.nvim_set_hl(0, "netrwPlain", { fg = normal.fg })        -- regular files
		vim.api.nvim_set_hl(0, "netrwExe", { fg = "#9ece6a", bold = true }) -- executables (green)
		vim.api.nvim_set_hl(0, "netrwSymLink", { fg = "#e0af68" })      -- symlinks (yellow)
		vim.api.nvim_set_hl(0, "netrwTreeBar", { fg = "#414868" })      -- tree bars

		-- Make netrw transparent (use normal background, not floating)
		vim.api.nvim_win_set_option(0, "winhighlight", "Normal:Normal")

		-- Hide statusline in netrw
		vim.opt_local.laststatus = 0
		vim.opt_local.ruler = false
	end,
})
