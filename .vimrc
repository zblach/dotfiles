" .vimrc - zblach 2014
" vim: set fmr={{{,}}} fdm='marker' ts=4 nospell tw=0 sbr=\\ noet
set nocompatible
filetype off

" Vim Settings & Options {{{
	" auto-scan files for vim settings
	set modeline 
	set modelines=10
	
	set laststatus=2
	set cursorline
	set shiftround
	
	set colorcolumn=80,+1
	
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
	
	" misc 
	set backspace=indent,eol,start
	set scrolloff=7
	set scrolljump=4
	set virtualedit="all,onemore"
	set display+=lastline
	
	" tab-expansion configuration
	set wildmenu
	set wildmode=longest,full
    set wildignorecase
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store
	
	set autoindent
	set expandtab
	set smarttab
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set nowrap
	set wrapmargin=0
" }}}
" Key Remapping {{{
	" Rebind leader key
	let mapleader=','
	
	" common bindings
	" toggles 
	nnor <leader>i :set list! list?<cr>
	nnor <leader>n :set number! number?<cr>
	nnor <leader>N :set relativenumber! relativenumber?<cr>
	nnor <leader>v :set paste! paste?<cr>
	nnor <leader>w :set wrap! wrap?<cr>
	
	nnor <silent><leader># :nohl<cr>
	" nnor <leader>? :map<cr> -- deprecated in favor of unite
	
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
	
	set noswapfile
	
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
" Language-specific configuration options {{{
    " cpp {{{
        let g:additional_cpp_sources = "/usr/local/include/boost/"
    " }}}
" }}}
" Bundles {{{
	" Neobundle Configuration {{{
		" Bootstrapping {{{
		if empty(glob("~/.vim/bundle/neobundle.vim"))
			echo "NeoBundle not found, bootstrapping."
			sil !mkdir -p ~/.vim/bundle/
			sil !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
		endif
		" }}}
		set runtimepath+=~/.vim/bundle/neobundle.vim/
		call neobundle#rc(expand('~/.vim/bundle/'))
		
		" NeoBundle is my package manager of choice
		NeoBundleFetch 'Shougo/neobundle.vim'
	" }}}
	NeoBundle 'bling/vim-airline' " powerline replacement {{{
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
		let g:airline_mode_map = {
			\ '__' : '---',
			\ 'n'  : 'NOR',
			\ 'i'  : 'INS',
			\ 'R'  : 'REP',
			\ 'c'  : 'CMD',
			\ 'v'  : 'VIS',
			\ 'V'  : 'VSL',
			\ '' : 'VBK',
			\ 's'  : 'SCH',
			\ 'S'  : 'SLN',
			\ '' : 'SBK',
		\ }
	" }}}
	
	" Shougo Bundles {{{
		NeoBundle 'Shougo/neocomplete' " tab-completion {{{
			" Use neocomplete.
			let g:acp_enableAtStartup = 0
			let g:neocomplete#enable_at_startup = 1
			let g:neocomplete#data_directory='~/.vim/cache/neocomplete'
			" Use smartcase.
			let g:neocomplete#enable_smart_case = 1
			let g:neocomplete#enable_fuzzy_completion = 1

            " additional C++ sources
            if (!exists('g:neocomplete#sources#include#paths'))
                let g:neocomplete#sources#include#paths = {}
                let g:neocomplete#sources#include#paths.cpp = ""
            endif

            let g:neocomplete#sources#include#paths.cpp .= ".,/usr/local/include/"
		" }}}
		NeoBundle 'luochen1990/rainbow' " rainbow brackets {{{
			let g:rainbow_active = 1
			let g:rainbow_conf = {
			\	'guifgs' : ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick', 'magenta'],
			\	'ctermfgs' : ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta'],
			\	'operators' : '_,_',
			\	'parentheses' : [['(',')'], ['\[','\]'], ['{','}'], ['<','>']],
			\	'separately' : {
			\		'*' : {},
			\		'vim' : {
			\			'parentheses' : [['{{{','}}}']]
			\		},
			\	},
			\}
		" }}}
		NeoBundle 'Shougo/neosnippet', {'depends':['honza/vim-snippets', 'Shougo/neosnippet-snippets']} " snippets {{{
			" NeoBundle 'honza/vim-snippets'
			" NeoBundle 'Shougo/neosnippet-snippets'
			let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
			let g:neosnippet#enable_snipmate_compatibility=1
		" }}}
		" shell-style tab completions {{{
			imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
			smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
			imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
			smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
		" }}}
		NeoBundle 'Shougo/unite.vim' " unite plugin {{{
			let g:unite_enable_start_insert=1
			let g:unite_winwidth=10
			let g:unite_split_rule='botright'
			
			nnor <silent> <leader>/ :<C-u>Unite grep:. -buffer-name=results<cr>
			if executable('ag')
				let g:unite_source_grep_command='ag'
				let g:unite_source_grep_default_opts = '--nogroup --nocolor'
				let g:unite_source_grep_recursive_opt = ''
				let g:unite_source_grep_encoding = 'utf-8'
			endif

            nnor <silent> <leader>? :Unite -buffer-name=keymap mapping<cr>
		
            NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
            NeoBundleLazy 'tsukkee/unite-help', {'autoload':{'unite_sources':'help'}}
            NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources':
                        \ 'colorscheme'}}
            NeoBundleLazy 'ujihisa/unite-locate', {'autoload':{'unite_sources':'locate'}}
            NeoBundleLazy 'thinca/vim-unite-history', { 'autoload' : { 'unite_sources' :
                        \ ['history/command', 'history/search']}}
            NeoBundleLazy 'osyo-manga/unite-filetype', { 'autoload' : {'unite_sources' :
                        \ 'filetype', }}
            NeoBundleLazy 'osyo-manga/unite-quickfix', {'autoload':{'unite_sources':
                        \ ['quickfix', 'location_list']}}
            " NeoBundleLazy 'osyo-manga/vim-snowdrop', {'autoload':{'unite_sources': ['snowdrop']}}
            NeoBundleLazy 'osyo-manga/unite-fold', {'autoload':{'unite_sources':'fold'}}
            NeoBundleLazy 'tacroe/unite-mark', {'autoload':{'unite_sources':'mark'}}
            NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources': 
                        \['file_mru', 'directory_mru']}}

		" }}}
		NeoBundleLazy 'Shougo/vimproc.vim', {'build':{'mac': 'make -f make_mac.mak', 'unix' : 'make -f make_unix.mak'}}


		" NeoBundle 'Shougo/vimshell.vim'
	" }}}
	NeoBundle 'sjl/gundo.vim' " undotree {{{
		map <leader>u :GundoToggle<cr>
	" }}}
	NeoBundle 'chrisbra/NrrwRgn' " narrow region {{{
		let g:nrrw_rgn_nohl=1
	" }}}
	
	" tpope Bundles {{{
		NeoBundle 'tpope/vim-fugitive'
		NeoBundle 'tpope/vim-speeddating'
		NeoBundle 'tpope/vim-surround'
		NeoBundle 'tpope/vim-repeat'
		NeoBundle 'tpope/vim-unimpaired'
	" }}}
	" tommcdo bundles {{{
		NeoBundle 'tommcdo/vim-lion'
		NeoBundle 'tommcdo/vim-fugitive-blame-ext', {'depends' : 'tpope/vim-fugitive'}
		NeoBundle 'tommcdo/vim-ninja-feet'
		NeoBundle 'tommcdo/vim-text-objects'
	" }}}
	NeoBundle 'kien/ctrlp.vim' " ctrlp {{{
		let g:ctrlp_regex_search=1
		let g:ctrlp_cmd='CtrlPLastMode --dir'
		let g:ctrlp_use_caching=1
		let g:ctrlp_cache_dir="~/.vim/cache/ctrlp"
		let g:ctrlp_extensions=['quickfix','dir','funky','undo','changes','line']
		if executable('ag')
			set grepprg=ag\ --nogroup\ --nocolor
			let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
		endif
		nnor <leader>gw :CtrlP<c-\>w<cr>
	" }}}
	NeoBundleLazy 'tacahiroy/ctrlp-funky.git', {'depends': ['kien/ctrlp.vim']} " {{{
		let g:ctrlp_extensions = ['funky']
	" }}}
	" Scroolose bundles {{{
		NeoBundle 'scrooloose/nerdtree'
		NeoBundle 'scrooloose/syntastic' " Syntastic {{{
			" Enable jsl as a javascript checker for syntastic
			let g:syntastic_javascript_checkers=['jsl']
			
			" symbols
			let g:syntastic_check_on_open=1
			let g:syntastic_warning_symbol='>'
			let g:syntastic_error_symbol='x'
			let g:syntastic_style_error_symbol='*'
			let g:syntastic_style_warning_symbol='+'
			
			let g:syntastic_enable_highlighting=1
			let g:syntastic_stl_format = '⮂[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
			
			" c++ options
			let g:syntastic_cpp_compiler = 'clang++'
			let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
            let g:syntastic_cpp_include_dirs=['/usr/local/include']
		" }}}
	" }}}
	NeoBundle 'ciaranm/detectindent' " {{{
		let g:detectindent_preferred_indent=4
		let g:detectindent_preferred_expandtab=0
		au BufReadPost * :DetectIndent
	" }}}
	NeoBundle 'junegunn/vim-easy-align' " {{{
		vmap <Enter> <Plug>(EasyAlign)
		nmap <Leader>a <Plug>(EasyAlign)
	" }}}
	NeoBundle 'benmills/vimux' " {{{
		let g:VimuxPromptString=":t! "
		
		nnor <leader>!! :VimuxRunLastCommand
		nnor <leader>!<space> :VimuxPromptCommand<cr>
		nnor <leader>!q :VimuxCloseRunner<cr>
		nnor <leader>!x :VimuxInterruptRunner<cr>
		nnor <leader>!z :VimuxZoomRunner<cr>
	" }}}
	NeoBundle 'nathanaelkane/vim-indent-guides'
	NeoBundle 'Lokaltog/vim-easymotion'
	" Disabled legacy bundles {{{
		" YankRing
		" grep
		" vim-multiedit
		" vim-snipmate
	" }}}
	"NeoBundle 'terryma/vim-expand-region'
	NeoBundle 'terryma/vim-multiple-cursors'
	
	NeoBundle 'szw/vim-ctrlspace' " {{{
		let g:airline_exclude_preview = 1
	" }}}
	
	NeoBundle 'bkad/CamelCaseMotion' " {{{
		" overwrite default behaviour
		map <silent> w <Plug>CamelCaseMotion_w
		map <silent> b <Plug>CamelCaseMotion_b
		map <silent> e <Plug>CamelCaseMotion_e
		sunmap w
		sunmap b
		sunmap e
		
		" overwrite behaviour for text objects
		omap <silent> iw <Plug>CamelCaseMotion_iw
		xmap <silent> iw <Plug>CamelCaseMotion_iw
		omap <silent> ib <Plug>CamelCaseMotion_ib
		xmap <silent> ib <Plug>CamelCaseMotion_ib
		omap <silent> ie <Plug>CamelCaseMotion_ie
		xmap <silent> ie <Plug>CamelCaseMotion_ie
	" }}}
	
	NeoBundle 'guns/vim-sexp'
	NeoBundleLazy 'majutsushi/tagbar', {'autoload':{'commands':'TagbarToggle'}} " {{{
		let g:tagbar_left=1
		nnor <leader>t :TagbarToggle <cr>
	" }}}
	
	NeoBundle 'airblade/vim-gitgutter'
	NeoBundle 'mhinz/vim-tmuxify'
	NeoBundle 'gregsexton/gitv'
	" Language-specific bundles {{{
		" python
		NeoBundleLazy 'ivanov/vim-ipython', {'autoload':{'filetypes':['python']}}
		
		" scala
		NeoBundleLazy 'derekwyatt/vim-scala', {'autoload':{'filetypes':['scala']}}
		NeoBundleLazy 'megaannum/vimside', {'autoload':{'filetypes':['scala']}, 'depends': ['Shougo/vimshell.vim', 'Shougo/vimproc']}
		
		" haskell
		NeoBundleLazy 'ujihisa/neco-ghc', {'autoload':{'filetypes':['ghc']}}
		
		" csv
		NeoBundleLazy 'chrisbra/csv.vim', {'autoload':{'filetypes':['csv']}}
		
		" swift
		NeoBundleLazy 'toyamarinyon/vim-swift', {'autoload':{'filetypes':['swift','playground']}}
		
		" markdown
		NeoBundleLazy 'nelstrom/vim-markdown-folding', {'autoload':{'filetypes':['markdown','md']}}
		
		" rust
		NeoBundleLazy 'wting/rust.vim', {'autoload':{'filetypes':['rust', 'rs']}}
	" }}}
" }}}
" Colors {{{
	NeoBundleLazy 'chrisbra/Colorizer', {'autoload':{'commands':'ColorToggle'}}
	NeoBundleLazy 'junegunn/limelight.vim', {'autoload':{'commands':'Limelight'}}
	NeoBundleLazy 'junegunn/goyo.vim', {'autoload':{'commands':'Goyo'}} " {{{
		nnor <leader>G :Goyo<cr>
		function! GoyoBefore()
			Limelight
			silent !tmux set status off
		endfunction
		
		function! GoyoAfter()
			Limelight!
			silent !tmux set status on
		endfunction
		let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]
	" }}}
	
	NeoBundle 'chriskempson/base16-vim'
	NeoBundle 'sjl/badwolf'
	NeoBundle 'w0ng/vim-hybrid'
	NeoBundle 'trapd00r/neverland-vim-theme'
	NeoBundle 'junegunn/seoul256.vim'
	
	set background=dark
	let b:colorscheme = 'badwolf' 
" }}}
" Misc tricks & hax {{{
	" Automatically source .vimrc and local on modification
	au! BufWritePost ~/{,.local}.{g,}vimrc source ~/.vimrc
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
	
	" rust
	au FileType rust setlocal makeprg='rustc "%"'
" }}}

filetype plugin indent on
syntax on
exe "colorscheme ". b:colorscheme
NeoBundleCheck
