-------------
-- Keymaps --
-------------
local map = vim.keymap.set

-- Set the \ as the "my starting shorcuts" key --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<M-S-l>", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format File" })

map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Open The File Manager" })
map("n", "<leader>e", function()
	local api = require("nvim-tree.api")
	if api.tree.is_visible() then
		api.tree.focus()
	elseif vim.bo.filetype == "NvimTree" then
		vim.cmd("wincmd p")
	else
		api.tree.open()
	end
end, { desc = "Toogle FM" })

map("n", "<leader>/", "<cmd>Inscom<CR>", {})

map("n", "<leader>fp", "<cmd>Telescope live_grep<CR>", { desc = "Find Files In Currant Dir" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find In Nvim Docs" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find In Nvim Docs" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")

map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>")
map("n", "]c", function()
	require("gitsigns").nav_hunk("next")
end, { desc = "Next Git Change" })

map("n", "[c", function()
	require("gitsigns").nav_hunk("prev")
end, { desc = "Last Git Change" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>")

---------
-- LSP --
---------
map("n", "gd", vim.lsp.buf.definition)
map("n", "gr", vim.lsp.buf.references)
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>d", vim.diagnostic.open_float)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "[d", vim.diagnostic.goto_prev)

------------
-- tabbar --
------------
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
map("n", "<leader>w", "<cmd>bdelete<CR>")

----------------
-- Window Mgr --
----------------
-- Create a vertical split.
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Vertical split" })

-- Create a horizontal split.
map("n", "<leader>h", "<cmd>split<CR>", { desc = "Horizontal split" })

-- Move to the window on the left.
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })

-- Move to the window below.
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })

-- Move to the window above.
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- Move to the window on the right.
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Increase the window height.
map("n", "<M-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })

-- Decrease the window height.
map("n", "<M-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })

-- Increase the window width.
map("n", "<M-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Decrease the window width.
map("n", "<M-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })

-- Make all windows approximately equal in size.
map("n", "<leader>=", "<C-w>=", { desc = "Equalise window sizes" })

-- Close the current window.
map("n", "<leader>q", "<cmd>close<CR>", { desc = "Close window" })
