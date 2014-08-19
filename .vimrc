" .vimrc - zblach 2014
" vim: set fmr={{{,}}} fdm=marker ts=4 nospell tw=0 sbr=\\ noet nosta 
set nocompatible
filetype off

" Vim Settings & Options {{{
	set laststatus=2
	set cursorline
	set shiftround
	
	set colorcolumn=80,+1
	
	" search and navigation
	set incsearch ignorecase smartcase hlsearch
	
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
	set scrolloff=7 scrolljump=4
	set virtualedit="all,onemore"
	set display+=lastline
	
	" tab-expansion configuration
	set wildmenu wildmode=longest,full wildignorecase wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store
	
	set autoindent
	set expandtab smarttab tabstop=4 softtabstop=4 shiftwidth=4 nowrap
	set wrapmargin=0
	
	" modeline overrides default options
	set modeline modelines=10

" }}}
" Key Remapping {{{
	" Rebind leader key
	let mapleader=','
	
	" common bindings
	map Y y$

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
	xnor < <gv
	xnor > >gv
	
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
	set backupdir=~/.vim_temp/backup/ backup
	set undodir=~/.vim_temp/undo/ undofile undolevels=10000
	set viewdir=~/.vim_temp/views/

	
	" bind view creation to focus loss/gain
	au BufWinLeave * if expand("%") != "" | mkview | endif
	au BufWinEnter * if expand("%") != "" | silent loadview | endif
" }}}
" Language-specific configuration options {{{
	" cpp {{{
		let g:additional_cpp_sources = "/usr/local/include/boost/"
	" }}}

	" vim {{{
		set path+=~/.vim/bundle/
		set inex=strpart(v:fname,strridx(v:fname,'/')+1).'/README' " trim repo name
		set sua=.md,.txt,.markdown
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

		let g:neobundle#install_max_processes = 100 " overdrive!
		let g:neobundle#install_process_timeout = 360

	" Disabled bundles {
		"NeoBundleDisable jonstoler/werewolf.vim
		NeoBundleDisable vim-multiedit
	" }
	" }}}
	" fuck the arrow-keys
	NeoBundle 'wikitopian/hardmode' " {{{
		au BufReadPost * silent! call HardMode()
		let g:HardMode_level = 'wannabe'
	" }}}
	" Language-specific bundles {{{
		" vim
		NeoBundleLazy 'dbakker/vim-lint', {'autoload':{'filetypes':['vim']}}

		" python
		NeoBundleLazy 'ivanov/vim-ipython', {'autoload':{'filetypes':['python']}}
		NeoBundleLazy 'nvie/vim-flake8', {'autload':{'filetypes':['python']}}

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

		" hex
		NeoBundleLazy 'Shougo/vinarise.vim', {'autoload':{'filetypes':['bin', 'xxd', 'hex']}}
	" }}}
	NeoBundle 'bling/vim-airline' " powerline replacement {{{
		set noshowmode
		
		let g:airline_powerline_fonts = 1
		
		let g:airline_left_sep = '⮀'
		let g:airline_left_alt_sep = '⮁'
		let g:airline_right_sep = '⮂'
		let g:airline_right_alt_sep = '⮃'
		
		let g:airline_symbols = { 
				 \ 'paste': 'paste',
				 \ 'space': ' ',
				\ 'branch': '⭠',
				\ 'linenr': '⭡',
			  \ 'readonly': '⭤',
			\ 'whitespace': ' '
		\ }
		
		let g:airline#extensions#whitespace#enabled = 0
		
		let g:airline#extensions#tabline#enabled = 1
		
		let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
		
		let g:airline#extensions#tabline#left_sep = '⮀'
		let g:airline#extensions#tabline#left_alt_sep = '⮁'
		let g:airline#extensions#tabline#right_sep = '⮂'
		let g:airline#extensions#tabline#right_alt_sep = '⮃'
		let g:airline_mode_map = {
			\ '__': '---',
			 \ 'n': 'NOR',
			 \ 'i': 'INS',
			 \ 'R': 'REP',
			 \ 'c': 'CMD',
			 \ 'v': 'VIS',
			 \ 'V': 'VSL',
			\ '': 'VBK',
			 \ 's': 'SCH',
			 \ 'S': 'SLN',
			\ '': 'SBK',
		\ }
	" }}}
	NeoBundle 'dhruvasagar/vim-dotoo'
	NeoBundle 'jceb/vim-orgmode'
	NeoBundle 'dbakker/vim-projectroot'
	" Shougo Bundles {{{
		NeoBundle 'Shougo/neocomplete' " tab-completion {{{
			" Use neocomplete.
			let g:acp_enableAtStartup = 0
			let g:neocomplete#enable_at_startup = 1
			let g:neocomplete#data_directory = '~/.vim/cache/neocomplete'
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
			NeoBundle 'Shougo/unite.vim', {'depends':['Shougo/vimproc.vim']} " unite plugin {{{
			call unite#custom#profile('default', 'context', {
				\ 'log' : 1,
			\ })
			let g:unite_source_history_yank_enable=2
			let g:unite_enable_start_insert=1
			let g:unite_winwidth=10
			let g:unite_split_rule='botright'

			call unite#filters#matcher_default#use(['matcher_fuzzy'])
			call unite#filters#sorter_default#use(['sorter_rank'])
			
			nnor <silent> <leader>/ :<C-u>Unite -buffer-name=results grep:.<cr>
			if executable('ag')
				let g:unite_source_grep_command = 'ag'
				let g:unite_source_grep_default_opts = '--nogroup --nocolor'
				let g:unite_source_grep_recursive_opt = ''
				let g:unite_source_grep_encoding = 'utf-8'

				let g:unite_source_rec_async_command = 'ag --follow --nocolor --group --hidden -g ""'
			endif

			nnor <silent> <leader>? :<C-u>Unite -buffer-name=keymap mapping<cr>
			nnor <silent> <leader>b :<C-u>Unite -buffer-name=buffers buffer<cr>
			nnor <silent> <leader>m :<C-u>Unite -buffer-name=mark mark<cr>

			" replacing CtrlP plugin?
			nnor <silent>  :<C-u>Unite -buffer-name=files file_rec/async<cr>
			let g:unite_source_file_async_command = "find"
			" moar bundles {{{	
				NeoBundleLazy 'Shougo/neomru.vim',         {'autoload': {'unite_sources': ['file_mru', 'directory_mru']}}
				NeoBundleLazy 'Shougo/unite-outline',      {'autoload': {'unite_sources': 'outline'}}
				NeoBundleLazy 'osyo-manga/unite-filetype', {'autoload': {'unite_sources': 'filetype'}}
				NeoBundleLazy 'osyo-manga/unite-fold',     {'autoload': {'unite_sources': 'fold'}}
				NeoBundleLazy 'osyo-manga/unite-quickfix', {'autoload': {'unite_sources': ['quickfix', 'location_list']}}
				NeoBundleLazy 'osyo-manga/vim-snowdrop',   {'autoload': {'unite_sources': 'snowdrop'}}
				NeoBundleLazy 'tacroe/unite-mark',         {'autoload': {'unite_sources': 'mark'}}
				NeoBundleLazy 'thinca/vim-unite-history',  {'autoload': {'unite_sources': ['history/command', 'history/search']}}
				NeoBundleLazy 'tsukkee/unite-help',        {'autoload': {'unite_sources': 'help'}}
				NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload': {'unite_sources': 'colorscheme'}} " {{{
					call unite#custom#profile('source/colorscheme', 'context', {
					\	'auto_preview' : 1,
					\	         'log' : 0,
					\	'start_insert' : 0,
					\ })
					nnor <leader>c <C-u>:Unite colorscheme<cr>
				" }}}
				NeoBundleLazy 'ujihisa/unite-locate', {'autoload':{'unite_sources':'locate'}}
			" }}}
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
		NeoBundle 'tommcdo/vim-lion' " {{{
			vmap <Enter> gl/
			vmap <S-Enter> gL/
		" }}}
		NeoBundle 'tommcdo/vim-fugitive-blame-ext', {'depends' : 'tpope/vim-fugitive'}
		NeoBundle 'tommcdo/vim-ninja-feet'
		NeoBundle 'tommcdo/vim-text-objects'
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
	" NeoBundle 'junegunn/vim-easy-align' " removed in favor of vim-lion
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
	NeoBundleLazy 'felixr/vim-multiedit' " multi-editing for vim
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
" }}}
" Colors {{{
	NeoBundle 'luochen1990/rainbow' " rainbow brackets {{{
		let g:rainbow_active = 1
		let g:rainbow_conf = {
		\	'guifgs'      : ['RoyalBlue', 'DarkOrange', 'DarkOrchid', 'FireBrick', 'magenta'],
		\	'ctermfgs'    : ['lightblue', 'lightgreen', 'yellow'    , 'red'      , 'magenta'],
		\	'parentheses' : [['(',')']  , ['\[','\]'] , ['{','}']   , ['<','>'] ],
		\	'operators'   : '_,_',
		\	'separately'  : {
		\		'*'   : {},
		\		'vim' : {
		\			'parentheses' : [['{{{','}}}']]
		\		},
		\	},
		\}
	" }}}
	NeoBundleLazy 'chrisbra/Colorizer', {'autoload':{'commands':'ColorToggle'}}
	NeoBundleLazy 'jaxbot/semantic-highlight.vim', {'autoload':{'commands':'SemanticHighlight'}}
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

	NeoBundleLazy 'chriskempson/base16-vim' " {{{
		if has('gui_running')
			NeoBundleSource 'base16-vim'
		endif
	" }}}
	NeoBundle 'sjl/badwolf'
	NeoBundle 'w0ng/vim-hybrid'
	NeoBundle 'trapd00r/neverland-vim-theme'
	NeoBundle 'junegunn/seoul256.vim'
	NeoBundle 'altercation/vim-colors-solarized'
	NeoBundle 'baeuml/summerfruit256.vim'

	NeoBundleLazy 'chriskempson/base16-vim'

	if has('gui_running') 
		NeoBundleSource base16-vim
	endif
	NeoBundle 'jonstoler/werewolf.vim' " {{{
		let g:werewolf_change_automatically = 0
		let g:werewolf_day_themes   = ['seoul256-light', 'hybrid-light', 'morning']
		let g:werewolf_night_themes = ['seoul256'      , 'hybrid'      , 'evening']
	" }}}

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
	cno w!! exec 'w !sudo tee % >/dev/null' | e!
" }}}
" Language-specific settings {{{
	" xml
	if executable('xmllint')
		au FileType xml let &l:equalprg='xmllint --format --recover -'
	endif
	
	" rust
	if executable('rustc')
		au FileType rust setlocal makeprg='rustc "%"'
	endif
" }}}

filetype plugin indent on
syntax on
exe "colorscheme ". b:colorscheme
NeoBundleCheck
