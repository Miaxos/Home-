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

autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.elm set filetype=elm
autocmd BufNewFile,BufRead *.sbt set filetype=scala
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType typescript.tsx let b:coc_root_patterns = ['.git', '.env']
autocmd FileType typescript let b:coc_root_patterns = ['.git', '.env']
autocmd FileType javascript let b:coc_root_patterns = ['.git', '.env']



" ================ Fix ====================

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

call remote#host#RegisterPlugin('python3', '/home/anthonygriffon/.vim/bundle/deoplete.nvim/rplugin/python3/deoplete.py', [
      \ {'sync': 1, 'name': 'DeopleteInitializePython', 'type': 'command', 'opts': {}},
      \ ])

" =============== Vundle Initialization ===============
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

set clipboard=unnamed

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" ## ELM
Plugin 'andys8/vim-elm-syntax'
" ## Visual
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'morhetz/gruvbox'
" ## Navigation
Plugin 'scrooloose/nerdtree'
" ## Indentation
Plugin 'Yggdroot/indentLine'
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
" Plugin 'hail2u/vim-css3-syntax'
" Plugin 'tpope/vim-commentary'
" Plugin 'Yggdroot/indentLine'
" Plugin 'Vimjas/vim-python-pep8-indent'
" ## Linting
" Asyncronous linting with ALE
" Plugin 'w0rp/ale'
" Code completion vim
Plugin 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Typescript
Plugin 'leafgarland/typescript-vim'
" Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'MaxMEllon/vim-jsx-pretty'
" Scala
Plugin 'derekwyatt/vim-scala'
" C #
Plugin 'OmniSharp/omnisharp-vim'
" Vim dev icons
Plugin 'ryanoasis/vim-devicons'
" Carbon
Plugin 'kristijanhusak/vim-carbon-now-sh'

let g:carbon_now_sh_options =
      \ { 'bg': 'rgba(52%2C57%2C63%2C1)',
      \ 't': 'monokai' }

" ====================== C SHARP =============================
"
" Better with stdio server
let g:OmniSharp_server_stdio = 1

" Update semantic highlighting on BufEnter and InsertLeave
let g:OmniSharp_highlight_types = 2

" OmniSharp Roselyn server
let g:OmniSharp_server_path = '/Users/anthonygriffon/Dev/omnisharp-roslyn/artifacts/scripts/OmniSharp.Stdio'

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> gh :OmniSharpSignatureHelp<CR>
    autocmd FileType cs nnoremap <buffer> tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs inoremap <buffer> go :OmniSharpSignatureHelp<CR>
    autocmd FileType cs nnoremap <buffer> gdc :OmniSharpDocumentation<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> gcc :OmniSharpGlobalCodeCheck<CR>
augroup END

" Plugin 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
" Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plugin 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Plugin 'ap/vim-css-color'
"
"
let g:carbon_now_sh_options =
      \ { 'bg': 'rgba(52%2C57%2C63%2C1)',
      \ 't': 'monokai' }


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
set nowritebackup
set backupcopy=yes
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

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" ================ FZF plugin ========================

" In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10split enew' }
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse']}, <bang>0)
nmap <silent> <C-A> :Files<CR>

" https://github.com/neovim/neovim/issues/9718#issuecomment-559573308
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
let g:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {1..-1} | (basename {1..-1} && head -'.&lines.')"'

" ================ Indentation ========================
"
" set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" ================ Keep Fold ========================
"
" Keep fold done with zf when close and reopen files
"
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" ================ CoC.vim ========================
"
" if hidden not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=200

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> <Leader>z <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>a <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <Leader>g <Plug>(coc-definition)
nmap <silent> <Leader>t <Plug>(coc-type-definition)
nmap <silent> <Leader>i <Plug>(coc-implementation)
nmap <silent> <Leader>r <Plug>(coc-references)

" Metals decorator
" https://scalameta.org/metals/docs/editors/vim.html#worksheets
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

" Use K for show documentation in preview window
nnoremap <silent> <Leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <Leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <Leader>f  <Plug>(coc-format-selected)
nmap <Leader>f  <Plug>(coc-format-selected)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap = <Plug>(coc-format-selected)
nmap <leader>fo  <Plug>(coc-format-selected)

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" vmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <Leader>q  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>



" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Shortcuts for denite interface
" Show extension list
" nnoremap <silent> <space>e  :<C-u>Denite coc-extension<cr>
" Show symbols of current buffer
" nnoremap <silent> <space>o  :<C-u>Denite coc-symbols<cr>
" Search symbols of current workspace
" nnoremap <silent> <space>t  :<C-u>Denite coc-workspace<cr>
" Show diagnostics of current workspace
" nnoremap <silent> <space>a  :<C-u>Denite coc-diagnostic<cr>
" Show available commands
" nnoremap <silent> <space>c  :<C-u>Denite coc-command<cr>
" Show available services
" nnoremap <silent> <space>s  :<C-u>Denite coc-service<cr>
" Show links of current buffer
" nnoremap <silent> <space>l  :<C-u>Denite coc-link<cr>

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

" ================ RUSTFMT ================================

let g:rustfmt_autosave = 1


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

set conceallevel=0
