---- use alt+hjkl to move between split/vsplit panels ----
vim.api.nvim_set_keymap('t', '<A-h>', '<C-\\><C-n><C-w>h',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<A-l>', '<C-\\><C-n><C-w>l',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<A-j>', '<C-\\><C-n><C-w>j',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<A-k>', '<C-\\><C-n><C-w>k',{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k',{ noremap = true, silent = true })
---- end ----
