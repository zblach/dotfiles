" .vimrc - zblach 2014
" vim: set foldmarker={{{,}}} foldmethod=marker tabstop=2 nospell
set nocompatible
filetype off

" Vim Settings & Options {{{
	" auto-scan files for vim settings
	set modeline 
	set modelines=10

	set cursorline
	set shiftround

	" search and navigation
	set incsearch
	set ignorecase
	set smartcase
	set hls

	" terminal settings
	set encoding=utf-8
	set hidden
	set lazyredraw
	set ttyfast
	set shell=/bin/zsh
	set title
	set visualbell

	" unknown
	set laststatus=2
	set backspace=indent,eol,start
	set scrolloff=7
	set scrolljump=4
	set virtualedit="all,onemore"
	set display+=lastline
	set wildmenu
	set wildmode=full
	set wildignorecase
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store

	set autoindent
	set expandtab
	set smarttab
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
" }}}
" Key Remapping {{{
	" Rebind leader key
	let mapleader=','

	" common bindings
	nnor <leader>i :set list! list?<cr>
	nnor <leader>n :set number!<cr>
	nnor <leader>N :set relativenumber!<cr>
	nnor <leader>v :set paste! paste?<cr>
	nnor <leader>w :set wrap! wrap?<cr>

	nnor <leader><space> :silent nohl<cr>
	nnor <leader>? :map<cr>

	" search and navigation
	nnor j gj
	nnor k gk

    nnor n nzzzv
    nnor N Nzzzv
    nnor g; g;zz
    nnor g, g,zz

	" visual block reselect
	vnor < <gv
	vnor > >gv

	" let ; function as :
	nnor ; :

	" nuke 'ex' mode
	nnor Q <nop>
" }}}
" Display Character Settings {{{
	set listchars=tab:>-,eol:$,precedes:<,extends:>,trail:~,conceal:#,nbsp:_
	set fillchars=vert:\│,fold:-
	let &showbreak = '↪ '
" }}}
" Backups, History, and Views {{{
	sil !mkdir -p ~/.vim_temp/{views,backup,undo,cache}

	set backupdir=~/.vim_temp/backup/
	set backup

	set undodir=~/.vim_temp/undo/
	set undofile
	set undolevels=10000

	set viewdir=~/.vim_temp/views/

	" bind view creation to focus loss/gain
	au BufWinLeave * if expand("%") != "" | mkview | endif
	au BufWinEnter * if expand("%") != "" | silent loadview | endif
" }}}

" Bundles {{{
	" Neobundle Configuration {{{
		set runtimepath+=~/.vim/bundle/neobundle.vim/
		call neobundle#rc(expand('~/.vim/bundle/'))

		" NeoBundle is now the package manager of choice
		NeoBundleFetch 'Shougo/neobundle.vim'
	" }}}
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

	" Shougo Bundles
	NeoBundle 'Shougo/neocomplete'                   " tab-completion {{{
		" Use neocomplete.
		let g:acp_enableAtStartup = 0
		let g:neocomplete#enable_at_startup = 1
		let g:neocomplete#data_directory='~/.vim/cache/neocomplete'
		" Use smartcase.
		let g:neocomplete#enable_smart_case = 1
		let g:neocomplete#enable_fuzzy_completion = 1
	" }}}
	NeoBundle 'Shougo/neosnippet'                    " snippets {{{
		NeoBundle 'honza/vim-snippets'
		NeoBundle 'Shougo/neosnippet-snippets'
		let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
		let g:neosnippet#enable_snipmate_compatibility=1

	" }}}
	" shell-style tab completions
	imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
	imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
	smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
  " Disabled legacy bundles {{{
  " YankRing
  " detectIndent
  " gitv
  " grep
  " rainbow 
  " tlib_vim
  " vim-addon-mw-utils
  " vim-easymotion
  " vim-multiedit
  " vim-multiple-cursors
  " vim-repeat
  " vim-snipmate
  " }}}
" }}}

	NeoBundle 'Shougo/unite.vim'                      " unite plugin {{{
		let g:unite_enable_start_insert=1
		let g:unite_winwidth=10
		let g:unite_split_rule='botright'
	" }}}
	NeoBundle 'Shougo/vimproc.vim', {'build':{'mac': 'make -f make_mac.mak'}}

	NeoBundleLazy 'Shougo/vimshell.vim', {'depends': 'Shougo/vimshell.vim'}

	" tpope Bundles {{{
		NeoBundle 'tpope/vim-fugitive'
		NeoBundle 'tpope/vim-speeddating'
		NeoBundle 'tpope/vim-surround'
        NeoBundle 'tpope/vim-unimpaired'
	" }}}
	NeoBundle 'kien/ctrlp.vim'                        " ctrlp {{{
		let g:ctrlp_regex_search=1
	" }}}
	" Scroolose bundles {{{
		NeoBundle 'scrooloose/nerdtree'
		NeoBundle 'scrooloose/syntastic'                 " Syntastic {{{
			" Enable jsl as a javascript checker for syntastic
			let g:syntastic_javascript_checkers=['jsl']

			" symbols
			let g:syntastic_check_on_open=1
			let g:syntastic_warning_symbol='>'
			let g:syntastic_error_symbol='x'
			let g:syntastic_style_error_symbol='*'
			let g:syntastic_style_warning_symbol='+'

			let g:syntastic_enable_highlighting=1
			let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

			" c++ options
			let g:syntastic_cpp_compiler = 'clang++'
			let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
		" }}}
	" }}}
" }}}
NeoBundle 'sjl/gundo.vim'                        " undotree {{{
map <leader>u :GundoToggle<cr>
" }}}

NeoBundle 'guns/vim-sexp'
NeoBundleLazy 'majutsushi/tagbar', {'autoload':{'commands':'TagbarToggle'}}
" Language-specific bundles {{{
	" python
	NeoBundleLazy 'ivanov/vim-ipython', {'autoload':{'filetypes':['py']}}

	" scala
	NeoBundleLazy 'derekwyatt/vim-scala', {'autoload':{'filetypes':['scala']}}
	NeoBundleLazy 'megaannum/vimside', {'autoload':{'filetypes':['scala']}}

	" haskell
	NeoBundleLazy 'ujihisa/neco-ghc', {'autoload':{'filetypes':['ghc']}}

    " csv
    NeoBundleLazy 'chrisbra/csv.vim', {'autoload':{'filetypes':['csv']}}
" }}}
" Colors {{{
	NeoBundle 'chriskempson/base16-vim'
	NeoBundle 'sjl/badwolf'
	NeoBundle 'w0ng/vim-hybrid'
    NeoBundle 'trapd00r/neverland-vim-theme'

	set background=dark
	colorscheme badwolf 
	syntax on
" }}}
" Misc tricks & hax {{{
	" Automatically source .vimrc and local on modification
	au! BufWritePost ~/{,.local}.vimrc source ~/.vimrc
    " Source local vimrc, if exists {{{
    if filereadable(glob("~/.local.vimrc"))
        source ~/.local.vimrc
    endif
    if has("gui_running")
        source ~/.gvimrc
    endif
    " }}}

	" super sudo write
	cno w!! w !sudo tee % >/dev/null
" }}}
" Language-specific settings {{{
	" xml
	au FileType xml let &l:equalprg='xmllint --format --recover -'
" }}}

filetype plugin indent on
syntax on
NeoBundleCheck
