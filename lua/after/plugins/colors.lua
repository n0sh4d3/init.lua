return {
	{
		"aktersnurra/no-clown-fiesta.nvim",
		event = "BufEnter *.*",
		init = function()
			vim.cmd.colorscheme("no-clown-fiesta")

			-- remove background brr
			-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end
	},

}
