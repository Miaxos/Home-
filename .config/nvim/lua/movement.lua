local set = vim.opt
local use = require('packer').use

-- Treat long lines as break lines (useful when moving around in them)
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('', '<C-X>', ':bd<CR>')

vim.keymap.set('n', '<C-K>', '<C-U>')
vim.keymap.set('n', '<C-J>', '<C-D>')

use {
  'terryma/vim-multiple-cursors',
  config = function()
    vim.g.multi_cursor_select_all_word_key = '<C-y>'
  end
}
