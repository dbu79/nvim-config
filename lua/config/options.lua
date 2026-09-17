local opt = vim.opt

vim.opt.clipboard = "unnamedplus"

opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- tabs / indentation
vim.opt.tabstop = 4       -- width a <Tab> character displays as
vim.opt.softtabstop = 4   -- width when pressing <Tab> or <BS> with expandtab
vim.opt.expandtab = true  -- convert tabs to spaces
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true
opt.copyindent = true
opt.preserveindent = true

opt.background = "dark"

opt.fillchars = { eob = " " }

