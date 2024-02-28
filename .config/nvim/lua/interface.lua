local set = vim.opt
local cmd = vim.cmd
local use = require('packer').use

set.termguicolors = true

set.signcolumn = 'yes'
cmd [[highlight clear SignColumn]]

-- colors/gruvbox.vim
-- cmd [[
-- colorscheme gruvbox
-- ]]


use 'wakatime/vim-wakatime'
use {
  "ellisonleao/gruvbox.nvim",
-- commit = 'e863942494d7c72a7c8d2c54cf651f28fc5a76ab',
  config = function()
    vim.o.background = 'dark'
    vim.cmd('colorscheme gruvbox')
    require("gruvbox").setup({
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = true,
      },
      contrast = "",
      overrides = {
        ['@comment.documentation'] = { link = "GruvboxOrange" }
      }
    })
    require("gruvbox").load()
  end
}

use {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup()
  end,
}

use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'gruvbox',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = ' ', right = ' ' },
        globalstatus = true,
      },

      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { 'branch' },
        lualine_d = {
          {
            'filename',
            path = 1,
            symbols = {
              modified = '+',
              readonly = '-',
              unnamed = '[No Name]',
            }
          }
        },
        lualine_x = {
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },

      extensions = {
        'quickfix'
      }
    })
  end
}

use {
  'kdheepak/tabline.nvim',
  after = 'lualine.nvim',
  config = function()
    require 'tabline'.setup {
      -- Defaults configuration options
      enable = true,

      options = {
        section_separators = { ' ', ' ' },
        component_separators = { '|', '|' },
        -- max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
      }
    }

    vim.cmd [[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
    ]]

    -- move among sbuffer
    vim.keymap.set('', '<C-l>', ':TablineBufferNext<CR>')
    vim.keymap.set('', '<C-h>', ':TablineBufferPrevious<CR>')
    -- close buffer
    vim.keymap.set('', '<C-X>', ':bdelete<CR>')
  end,
  requires = {
    { 'hoob3rt/lualine.nvim' },
    { 'kyazdani42/nvim-web-devicons' }
  }
}

use {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      signs                   = {
        add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      },
      signcolumn              = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl                   = true, -- Toggle with `:Gitsigns toggle_numhl`
      -- linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff               = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir            = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked     = true,
      current_line_blame      = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority           = 6,
      update_debounce         = 100,
      status_formatter        = nil, -- Use default
      max_file_length         = 40000, -- Disable if file is longer than this (in lines)
      preview_config          = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm                    = {
        enable = false
      },
    }
  end
}

use {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
}

set.background = 'dark'
set.colorcolumn = '80'

-- always show current position
set.ruler = true

-- height of the command bar
set.cmdheight = 1

-- always show signcolumns
set.signcolumn = 'yes'
-- cmd [[highlight clear SignColumn]]

-- Show matching brackets when text indicator is over them
set.showmatch = true
-- How many tenths of a second to blink when matching brackets
set.matchtime = 2

-- Display relative line numbers and absolute line number for the current line
set.number = true

-- highlight the screen line of the cursor
set.cursorline = true
set.cursorcolumn = false

-- Highlight the screen line of the cursor with H
vim.keymap.set('n', 'H', ':set cursorline!<CR>')

-- ================ Scrolling ========================

-- Start scrolling when we're 8 lines away from margins
set.scrolloff = 8
set.sidescrolloff = 15
set.sidescroll = 1

use {
  'voldikss/vim-floaterm',
  config = function()
    vim.g.floaterm_opener = 'edit'
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    vim.keymap.set('n', '<leader>p', ':FloatermNew --name=terminal ranger<CR>', { silent = true })
  end
}

-- TO CHECK BEFORE MERGING

-- Specify the behavior when switching between buffers
set.switchbuf = 'useopen'
