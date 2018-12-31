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

" Leeader
let mapleader = 'ù'

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
syntax on


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
" ## Search
" -> option
Plugin 'haya14busa/incsearch.vim'
" ## Fuzzy Find
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

" Plugin 'kien/ctrlp.vim'
" Plugin 'jelera/vim-javascript-syntax'
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'Raimondi/delimitMate'
" Plugin 'pangloss/vim-javascript'
" Plugin 'othree/html5.vim'
"" Plugin 'Yggdroot/indentLine'
" Plugin 'hail2u/vim-css3-syntax'
" Plugin 'tpope/vim-commentary'
" Plugin 'terryma/vim-multiple-cursors'
" Plugin 'Yggdroot/indentLine'
" Plugin 'Vimjas/vim-python-pep8-indent'
" Plugin 'w0rp/ale'
" Plugin 'ap/vim-css-color'

call vundle#end()            " required

filetype plugin indent on    " required

" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)

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
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


" ================ Vim GitGutter ========================

set updatetime=100

" ================ ALE Plugins ========================

" JS - AlE Correction
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_use_global = 0
let g:multi_cursor_next_key='<C-n>'


let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#docs = 1

let g:deoplete#sources#ternjs#filetypes = [ 'jsx' ]

set conceallevel=0
