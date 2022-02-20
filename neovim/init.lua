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

require('plugins')
require('input')
