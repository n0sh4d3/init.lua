local mappings = {
    ['('] = { '()<Left>', { noremap = true, silent = true } },
    ['['] = { '[]<Left>', { noremap = true, silent = true } },
    ['{'] = { '{}<Left>', { noremap = true, silent = true } },
    ['"'] = { '""<Left>', { noremap = true, silent = true } },
    ["'"] = { "''<Left>", { noremap = true, silent = true } },
}

for lhs, rhs in pairs(mappings) do
    local mapping = rhs[1]
    local options = rhs[2]
    vim.api.nvim_set_keymap('i', lhs, mapping, options)
end
