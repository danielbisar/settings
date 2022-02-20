-- do not abonden hidden buffers
vim.opt.hidden = true

-- show line numbers
vim.opt.number = true

-- merge sign and number column
vim.opt.signcolumn = "number"

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- tab
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.wildmenu = true

--vim.opt.ale_disable_lsp = 1
--vim.opt.ale_sign_error = ''
--vim.opt.ale_sign_warning = ''


require('plugins')
require('input')
