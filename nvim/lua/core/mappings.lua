-- \  e - Leader - специальная клавиша для команд
vim.g.mapleader = " "
vim.o.cursorlineopt = 'both'

local map = vim.keymap.set

map('i', 'jj', '<Esc>')
map('i', 'оо', '<Esc>')

-- Buffers
map('n', '<leader>w', ':w<CR>')
-- map({'n','i','v'}, '<C-s>', '<cmd>wa<CR>')
map('n', '<leader>nh', ':noh<CR>')

-- Navigation
map('n', '<c-k>', ':wincmd k<CR>')
map('n', '<c-j>', ':wincmd j<CR>')
map('n', '<c-h>', ':wincmd h<CR>')
map('n', '<c-l>', ':wincmd l<CR>')

-- Splits
map('n', '<leader>v', ':vsplit<CR>')
map('n', '<leader>s', ':split<CR>')

map('n', '<leader>e', ':Neotree left toggle reveal<CR>')

-- Buffers
map('n', '<Tab>', ':BufferLineCycleNext<CR>')
map('n', '<s-Tab>', ':BufferLineCyclePrev<CR>')
map('n', '<leader>x', ':BufferLinePickClose<CR>')
map('n', '<c-x>', ':BufferLineCloseOthers<CR>')
map('n', '<leader>bd', ':bd<CR>')

map('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts, { desc = "Lsp Rename"})
