vim.opt.mouse = "a"
vim.g.mapleader = ","

vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('n', ':', ';', { noremap = true })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('v', ':', ';', { noremap = true })

vim.api.nvim_set_keymap('n', '<F3>', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F4>', ':Telescope live_grep<CR>', { noremap = true })

