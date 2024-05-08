vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })




vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
end, opts)



vim.keymap.set("n", "<leader>e", ":GoIfErr<CR>")
vim.keymap.set("n", "<leader>p", ":GoPkgOutline<CR>")
vim.keymap.set("n", "<leader>t", ":GoAddAllTest<CR>")
vim.keymap.set("n", "<leader>l", ":GoListImports<CR>")

vim.api.nvim_set_keymap("n", "<leader>j", ":Lexplore<CR> :vertical resize 30<CR>", { noremap = true })

vim.keymap.set("n", "<leader><CR>", ":!python3 %<CR>")

vim.keymap.set("n", "<A-h>", ":ToggleTerm size=10 direction=horizontal<CR>")
vim.keymap.set("t", "<A-h>", "exit<CR>")
vim.keymap.set("n", "<A-i>", ":ToggleTerm size=10 direction=float<CR>")
vim.keymap.set("t", "<A-i>", "exit<CR>")
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<CR>")
vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>")
vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>")
vim.keymap.set("n", "<leader>ch", ":Telescope keymaps<CR>")
vim.keymap.set("n", "<leader>k", ":Telescope buffers<CR>")
