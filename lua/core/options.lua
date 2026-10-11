-------------
-- Options --
-------------

local opt = vim.opt

-- Code Folding
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "1"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Ln Num --
opt.number = true
opt.relativenumber = true

-- Indentation --
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

-- Search --
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- UI --
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.showmode = false
opt.cmdheight = 1
opt.laststatus = 3

opt.signcolumn = "no"
opt.numberwidth = 4
opt.fillchars = { eob = " " }
opt.winborder = "rounded"

-- Editing --
opt.wrap = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.virtualedit = "block"
opt.mouse = "a"
opt.confirm = true

-- Splits --
opt.splitright = true
opt.splitbelow = true

-- Completion --
opt.completeopt = { "menu", "menuone", "noselect" }

-- Undo --
opt.undofile = true

-- Clipboard --
opt.clipboard = "unnamedplus"
