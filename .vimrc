" .vimrc - zblach 2013
" vim: set foldmarker={{{,}}} foldmethod=marker tabstop=2 nospell
set nocompatible
filetype off

" Rebind leader key
let mapleader=','

" Bundles {{{
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))

" NeoBundle is now the package manager of choice
NeoBundleFetch 'Shougo/neobundle.vim'

"   Includes {{{
" snipmate dependencies {{{
"NeoBundleLazy 'tomtom/tlib_vim'
"NeoBundleLazy 'MarcWeber/vim-addon-mw-utils'
"NeoBundleLazy 'honza/vim-snippets'
"NeoBundleLazy 'garbas/vim-snipmate'
" }}}

" bundles
NeoBundle 'bling/vim-airline'                    " powerline replacement {{{
set noshowmode

let g:airline_powerline_fonts = 1

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'

let g:airline_symbols = {}
let g:airline_symbols.space = ' '
let g:airline_symbols.paste = 'paste'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
let g:airline_symbols.whitespace = ' '

let g:airline#extensions#whitespace#enabled = 0

let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮁'
let g:airline#extensions#tabline#right_sep = '⮂'
let g:airline#extensions#tabline#right_alt_sep = '⮃'
" }}}
NeoBundle 'chrisbra/csv.vim'
NeoBundle 'ciaranm/detectindent'                 " detect indent {{{
let g:detectindent_preferred_indent=4
au BufReadPost * :DetectIndent
" }}}
"NeoBundle 'fholgado/minibufexpl.vim'             " MiniBufExplorer {{{
"let g:miniBufExplHideWhenDiff=1
"let g:miniBufExplBRSplit=1
"let g:miniBufExplStatusLineText='Buffers'
"let g:miniBufExplCloseOnSelect=1
" }}}
NeoBundle 'kien/ctrlp.vim'                       " ctrlp {{{
set wildignore+="*.class,*/eclipse-bin/*"
" }}}
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'oblitum/rainbow'                      " rainbow brackets! {{{
let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm,xml}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick', 'magenta']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
" }}}
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'                 " Syntastic {{{
" Enable jsl as a javascript checker for syntastic
let g:syntastic_javascript_checkers=['jsl']

" symbols
let g:syntastic_check_on_open=1
let g:syntastic_warning_symbol='?'
let g:syntastic_error_symbol='x'
let g:syntastic_enable_highlighting=1
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

" c++ options
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
"}}}
NeoBundle 'sjl/gundo.vim'                        " undotree {{{
map <leader>u :GundoToggle<cr>
"}}}
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-surround'

" new toys :D
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/vimshell.vim'
"NeoBundle 'vim-scripts/YankRing.vim'         " Yankring {{{
let g:yankring_history_dir='~/.vim_temp/'
" }}}
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'gregsexton/gitv'
" }}}
" }}}

" Backups, History & Views {{{
" Make temporary directories
sil !mkdir -p ~/.vim_temp/{views,backup,swap,undo}
set viewdir=~/.vim_temp/views/
set backupdir=~/.vim_temp/backup/
set directory=~/.vim_temp/swap/
set backup
set history=5000

if v:version >= 703
  set undoreload=10000
  set undodir=~/.vim_temp/undo/
  set undofile
  set noswapfile
else
  set swapfile
endif

" bind view creation to focus gain/loss
au BufWinLeave * if expand("%") != "" | mkview | endif
au BufWinEnter * if expand("%") != "" | silent loadview | endif

" ignore whitespace differences in vimdiff
set diffopt+=iwhite
" }}}

" Color & Syntax {{{
set t_Co=256
set background=dark
colorscheme badwolf
syntax on

if &term =~ '*256color'
  " disable background color erase in a 256 color terminal
  set t_ut=
endif

let g:did_minibufexplorer_syntax_inits=1

set cursorline
set colorcolumn=80
set shiftround
" }}}

" Navigation {{{
" line movement
nnor j gj
nnor k gk

" search to middle of screen
nnor n nzzzv
nnor N Nzzzv
nnor g; g;zz
nnor g, g,zz

set hlsearch
set ignorecase
set incsearch
set smartcase
nnor <leader><space> :silent nohl<cr>
" }}}

" Terminal & Window Compatibility Options {{{
set backspace=2
set encoding=utf-8
set hidden
set laststatus=2
set lazyredraw
set modeline
set nowrap
set scrolloff=7
set scrolljump=4
set shell=/bin/zsh
set showcmd
set title
set ttyfast
set visualbell
" allow ';' to function as ':'
nnor ; :
" ... and nuke 'ex' mode while we're at it
nnor Q <nop>
" }}}

" Window Split/diff options {{{
set listchars=tab:>-,eol:$,precedes:<,extends:>,trail:~,conceal:#,nbsp:_
set fillchars=vert:\│,fold:-
let &showbreak = '↪ '

" auto resize on window-resize
"au VimResized * :wincmd =
" }}}

" Misc Unsorted Options {{{
set virtualedit="all,onemore"
" }}}

" Misc tricks & hax {{{
" Automatically source .vimrc and local on modification
au! BufWritePost ~/.vimrc{,.local} source ~/.vimrc

" super sudo write
cno w!! w !sudo tee % >/dev/null
" }}}

" Key maps {{{
nnor <leader>i :set list! list?<cr>
nnor <leader>v :set paste! paste?<cr>
nnor <leader>? :map<cr>
" }}}


" Source local vimrc, if exists {{{
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
if has("gui_running")
  source ~/.gvimrc
endif
" }}}
filetype plugin indent on


NeoBundleCheck
