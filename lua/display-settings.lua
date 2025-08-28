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
