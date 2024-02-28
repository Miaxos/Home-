local set = vim.opt
local use = require('packer').use

-- Allow vim clipboad <-> host clipboard to share data
-- @see https://ploegert.gitbook.io/til/tools/vim/allow-neovim-to-copy-paste-with-system-clipboard
-- don't know why not working with set.clipboard
vim.cmd [[
  set clipboard=unnamedplus
]]

-- Maximum width of text that is being inserted.
-- A longer line will be broken after white space to get this width.
set.textwidth = 80
set.linebreak = true

-- Use spaces instead of tabs
set.expandtab = true

-- 1 tab == 2 spaces
set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2

set.smartindent = true

-- highlight the region that just yanked
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

use {
  'nvim-treesitter/nvim-treesitter-context',
  requires = {
    {
      'nvim-treesitter/nvim-treesitter',
    },
  },
}

set.list = true
set.listchars:append("space:⋅")
set.listchars:append("eol:↴")

-- use {
--   "AckslD/nvim-neoclip.lua",
--   requires = {
--     -- you'll need at least one of these
--     { 'kkharji/sqlite.lua', module = 'sqlite' },
--     { 'nvim-telescope/telescope.nvim' },
--     -- {'ibhagwan/fzf-lua'},
--   },
--   config = function()
--     require('neoclip').setup({
--       history = 1000,
--       enable_persistent_history = true,
--       length_limit = 1048576,
--       continuous_sync = false,
--       db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
--       filter = nil,
--       preview = true,
--       default_register = '"',
--       default_register_macros = 'q',
--       enable_macro_history = false,
--       content_spec_column = false,
--       on_paste = {
--         set_reg = false,
--       },
--       on_replay = {
--         set_reg = false,
--       },
--       keys = {
--         telescope = {
--           i = {
--             select = '<cr>',
--             paste = '<c-p>',
--             paste_behind = '<c-k>',
--             replay = '<c-q>', -- replay a macro
--             delete = '<c-d>', -- delete an entry
--             custom = {},
--           },
--           n = {
--             select = '<cr>',
--             paste = 'p',
--             --- It is possible to map to more than one key.
--             -- paste = { 'p', '<c-p>' },
--             paste_behind = 'P',
--             replay = 'q',
--             delete = 'd',
--             custom = {},
--           },
--         },
--         fzf = {
--           select = 'default',
--           paste = 'ctrl-p',
--           paste_behind = 'ctrl-k',
--           custom = {},
--         },
--       },
--     })
--   end,
-- }

vim.keymap.set('', '<leader>à',
  ':lua require(\'telescope\').load_extension(\'neoclip\') vim.api.nvim_command(\'Telescope neoclip\')<CR>')


use {
  "lukas-reineke/indent-blankline.nvim",

  setup = function()
    vim.g.indent_blankline_char = '┆'
    vim.g.indent_blankline_space_char_blankline = ' '
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_show_current_context_start = true
  end,

-- requires = {
--   {
--     'nvim-treesitter/nvim-treesitter',
--   },
-- },
-- config = function()
--   require("ibl").setup({
--     -- space_char_blankline = " ",
--     -- show_current_context = true,
--     -- show_current_context_start = true,
--   })
-- end
}
