local set = vim.opt

vim.g.rustfmt_autosave = 1

-- Reload files changed outside vim
set.autoread = true

-- If this many milliseconds nothing is typed the swap file will be written to disk
-- Also used for the CursorHold autocommand event.
set.updatetime = 100

-- Leader
vim.g.mapleader = 'ù'

-- Time in milliseconds to wait for a mapped sequence to complete.
-- set.timeoutlen = 50

-- Configure backspace so it acts as it should act
set.backspace = 'eol,start,indent'
set.whichwrap = 'b,s<,>,h,l'

-- use Unix as the standard file type
set.ffs = 'unix,dos,mac'

-- Don't redraw while executing macros (good performance config)
set.lazyredraw = true

set.hidden = true

-- Custom font
set.guifont = 'Source Code Pro for Powerline'

-- No swap files
set.directory = os.getenv("HOME") .. '/.config/nvim/tmp/'

-- protect against crash-during-write
set.writebackup = true
-- but do not persist backup after successful write
set.backup = false
-- use rename-and-write-new method whenever safe
set.backupcopy = 'yes'
-- consolidate the writebackups, not a big deal either way, since they usually get deleted
set.backupdir = os.getenv("HOME") .. '/.config/nvim/backup/'

-- persist the undo tree for each file
set.undofile = true
set.undodir = os.getenv("HOME") .. '/.config/nvim/undodir'

-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd(
    'BufReadPost',
    {
      pattern = {'*'},
      callback = function()
          local ft = vim.opt_local.filetype:get()
          -- don't apply to git messages
          if (ft:match('commit') or ft:match('rebase')) then
              return
          end
          -- get position of last saved edit
          local markpos = vim.api.nvim_buf_get_mark(0,'"')
          local line = markpos[1]
          local col = markpos[2]
          -- if in range, go there
          if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
              vim.api.nvim_win_set_cursor(0,{line,col})
          end
      end
  }
)
