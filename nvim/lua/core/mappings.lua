-- \  e - Leader - специальная клавиша для команд
vim.g.mapleader = " "
vim.o.cursorlineopt = "both"

local map = vim.keymap.set

map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Buffers
map("n", "<leader>w", ":w<CR>", { desc = "Save buffer" })
-- map({'n','i','v'}, '<C-s>', '<cmd>wa<CR>')
map("n", "<leader>nh", ":noh<CR>", { desc = "Disable highlighting" })

-- Navigation
map("n", "<c-k>", ":wincmd k<CR>")
map("n", "<c-j>", ":wincmd j<CR>")
map("n", "<c-h>", ":wincmd h<CR>")
map("n", "<c-l>", ":wincmd l<CR>")

-- Splits
map("n", "<leader>v", ":vsplit<CR>")
map("n", "<leader>s", ":split<CR>")

map("n", "<leader>e", ":Neotree left toggle reveal<CR>")

-- Buffers
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "go to next Tab" })
map("n", "<s-Tab>", ":BufferLineCyclePrev<CR>", { desc = "go to prev Tab" })
map("n", "<leader>bc", ":BufferLinePickClose<CR>", { desc = "Pick buffer to close" })
map("n", "<leader>bd", ":bd<CR>", { desc = "Close this buffer" })
map("n", "<leader>bx", ":BufferLineCloseOther<CR>", { desc = "Close other buffers" })

map("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end, opts, { desc = "Lsp Rename" })
