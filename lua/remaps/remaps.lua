-- diagnoscitc stuff
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })


-- for toggable terminal
vim.keymap.set("n", "<A-h>", ":ToggleTerm size=10 direction=horizontal<CR>")
vim.api.nvim_set_keymap('t', '<A-h>', [[<C-\><C-n>:q!<CR>]], { noremap = true })

-- split buff
vim.keymap.set("n", "<leader>j", "<C-w><C-v><C-w><C-l>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- yanking stuff
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])


-- netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


vim.keymap.set(
    "n",
    "<leader>e",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("t", "<C-c", "<Esc><Esc>")

-- telescope extensions
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<CR>")
vim.keymap.set("n", "<leader>pf", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>")
vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>")
vim.keymap.set("n", "<leader>ch", ":Telescope keymaps<CR>")
vim.keymap.set("n", "<leader>k", ":Telescope buffers<CR>")
