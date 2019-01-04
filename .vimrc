"
" VIMRC Configuration
" @author: Anthony Griffon
" @desc: Do what the fuck you want with that.
"
" Vim configuration by Anthony Griffon.
" Inspired by: https://github.com/skwp/dotfiles/blob/master/vimrc
" ====================================================
"
"
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                  " required

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
syntax on

" Leader
let mapleader = 'ù'


" =============== Vundle Initialization ===============
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

set clipboard=unnamed

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" ## Visual
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'morhetz/gruvbox'
" ## Navigation
Plugin 'scrooloose/nerdtree'
" ## Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-rhubarb.git'
" ## Search
" -> option
Plugin 'haya14busa/incsearch.vim'
" ## Fuzzy Find
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
" ## Cursors
Plugin 'terryma/vim-multiple-cursors'
" Plugin 'kien/ctrlp.vim'
" Plugin 'jelera/vim-javascript-syntax'
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'Raimondi/delimitMate'
" Plugin 'pangloss/vim-javascript'
" Plugin 'othree/html5.vim'
"" Plugin 'Yggdroot/indentLine'
" Plugin 'hail2u/vim-css3-syntax'
" Plugin 'tpope/vim-commentary'
" Plugin 'Yggdroot/indentLine'
" Plugin 'Vimjas/vim-python-pep8-indent'
" ## Linting
" Asyncronous linting with ALE
Plugin 'w0rp/ale'
" Code completion vim
Plugin 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plugin 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Plugin 'ap/vim-css-color'

call vundle#end()            " required

filetype plugin indent on    " required

" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)
"
let g:ruby_host_prog = '/usr/local/lib/ruby/2.6.0/gems/neovim-0.8.0/exe/neovim-ruby-host'

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ KeyMappings ========================
"
" ### Commentary

vnoremap <Leader>c :s!^!#!<CR>
vnoremap <Leader>C :s!^#!!<CR>

" ### Navigation

" To go down by some lines with ctrl+j/k
map <C-K> <C-U>
map <C-J> <C-D>

" move among buffers with CTRL
map <C-L> :bnext<CR>
map <C-H> :bprev<CR>

" close buffer with CTRL
map <C-X> :bd<CR>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Airline plugin ========================

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme             = 'luna'
"branch parts
set lazyredraw
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
set guifont=Source\ Code\ Pro\ for\ Powerline "
let g:Powerline_symbols = 'unicode'
set laststatus=2

filetype plugin indent on
set t_Co=256
colorscheme gruvbox
set background=dark
set colorcolumn=80

:highlight LineNr ctermfg=green

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Remember info about open buffers on close
set viminfo^=%

" ================ FZF plugin ========================

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" ================ Indentation ========================
"
" set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" ================ NERDTree Plugin ========================

" Show hidden files inside NERDTree
let NERDTreeShowHidden=1
" Autoquit NerdTREE after openning a file
let NERDTreeQuitOnOpen=1

" open nerd tree
map <C-P> :NERDTreeToggle<CR>

" open nerd tree at the file with ù+p
nnoremap <Leader>p :NERDTreeFind<CR>

" To disable the weird ? for help
let NERDTreeMinimalUI = 0
let NERDTreeDirArrows = 1


" ================ Vim GitGutter ========================

set updatetime=100

" ================ ALE Plugins ========================

" JS - AlE Correction
" let g:ale_linters = { 'javascript': ['eslint', 'tsserver'] }
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_set_highlights = 1
let g:ale_javascript_eslint_use_global = 0
let g:multi_cursor_next_key='<C-n>'
let g:ale_completion_enabled = 1

" ================ DEOPLETE Plugins ========================

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#docs = 1

" ================ DEOPLETE TernJS Plugins ========================
"
let g:deoplete#sources#ternjs#filetypes = [ 'js', 'jsx' ]
" Set bin if you have many instalations
let g:deoplete#sources#ternjs#tern_bin = '/usr/local/bin/tern'
let g:deoplete#sources#ternjs#timeout = 1

" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

" Whether to include the distance (in scopes for variables, in prototypes for
" properties) between the completions and the origin position in the result
" data. Default: 0
let g:deoplete#sources#ternjs#depths = 1

" Whether to include documentation strings (if found) in the result data.
" Default: 0
let g:deoplete#sources#ternjs#docs = 1

" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the
" client side. Default: 1
let g:deoplete#sources#ternjs#filter = 0

" Whether to use a case-insensitive compare between the current word and
" potential completions. Default 0
let g:deoplete#sources#ternjs#case_insensitive = 1

" When completing a property and no completions are found, Tern will use some
" heuristics to try and return some properties anyway. Set this to 0 to
" turn that off. Default: 1
let g:deoplete#sources#ternjs#guess = 0

" Determines whether the result set will be sorted. Default: 1
let g:deoplete#sources#ternjs#sort = 0

" When disabled, only the text before the given position is considered part of
" the word. When enabled (the default), the whole variable name that the cursor
" is on will be included. Default: 1
let g:deoplete#sources#ternjs#expand_word_forward = 0

" Whether to ignore the properties of Object.prototype unless they have been
" spelled out by at least two characters. Default: 1
let g:deoplete#sources#ternjs#omit_object_prototype = 0

" Whether to include JavaScript keywords when completing something that is not
" a property. Default: 0
let g:deoplete#sources#ternjs#include_keywords = 1

" If completions should be returned when inside a literal. Default: 1
let g:deoplete#sources#ternjs#in_literal = 0

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'typescript': ['tsserver'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio', 'tsserver'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089', 'tsserver'],
    \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_loggingFile = '/Users/anthonygriffon/Dev/lc.log'

nnoremap <F11> :call LanguageClient#textDocument_hover()<CR>
nnoremap <F12> :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader> <F2> :call LanguageClient#textDocument_rename()<CR>


set conceallevel=0
