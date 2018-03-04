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


" =============== Vundle Initialization ===============
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

set clipboard=unnamed

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'morhetz/gruvbox'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/html5.vim'
" Plugin 'Yggdroot/indentLine'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Yggdroot/indentLine'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'haya14busa/incsearch.vim'
Plugin 'w0rp/ale'

" VueJS
Plugin 'posva/vim-vue'

au BufNewFile,BufRead *.vue setf vue

call vundle#end()            " required

filetype plugin indent on    " required

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

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

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme             = 'luna'
"branch parts
"let g:airline_enable_branch     = 1
"let g:airline_enable_syntastic  = 1
""set lazyredraw
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
set guifont=Source\ Code\ Pro\ for\ Powerline "
let g:Powerline_symbols = 'unicode'
set laststatus=2
filetype plugin indent on
" set term=builtin_xterm
au BufRead,BufNewFile *.pro set filetype=prolog
au BufRead,BufNewFile *.rp set syntax=rp
au BufRead,BufNewFile *.pro set syntax=prolog
set t_Co=256
colorscheme gruvbox
set background=dark
set colorcolumn=80
:highlight LineNr ctermfg=green

" Mapping vim

" move among buffers with CTRL
" map <C-J> :bnext<CR>
" map <C-K> :bprev<CR>
map <C-l> :NERDTreeToggle<CR>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" F18
set <F18>=<F18>

" map <C-U> <F18>
map <C-K> <C-U>
map <C-J> <C-D>

" map move lines
" ALT+j
nnoremap ê :m .+1<CR>==
inoremap ê <Esc>:m .+1<CR>==gi
vnoremap ê :m '>+1<CR>gv=gv
" ALT+k
nnoremap ë :m .-2<CR>==
inoremap ë <Esc>:m .-2<CR>==gi
vnoremap ë :m '<-2<CR>gv=gv
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
" Remember info about open buffers on close
set viminfo^=%

"Indent
" set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" JS - AlE Correction
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_use_global = 0
let g:multi_cursor_next_key='<C-n>'


let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#docs = 1

let g:deoplete#sources#ternjs#filetypes = [ 'jsx' ]

set conceallevel=0
