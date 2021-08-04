-- Settings
local opt = vim.opt
--local g = vim.g

vim.cmd [[

    set nowrap
    set nobackup
    set nowritebackup
    set noerrorbells
    set noswapfile
    set noshowmode
    set autoindent
    set smartindent
    set ignorecase
    set smartcase
    set cursorline

    syntax on
]]


-- UI settings
opt.number = true
opt.numberwidth = 4
opt.cursorline = true
opt.termguicolors = true

-- tab size
opt.tabstop = 4
opt.shiftwidth = 0
opt.expandtab = true
