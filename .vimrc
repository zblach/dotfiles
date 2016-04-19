" .vimrc - zblach 2014
" vim: fmr={+,}- fdm=marker ts=2 nospell tw=0 sbr=\\ et nosta
set nocompatible
filetype off

" core vim settings {+
  let g:colorscheme='badwolf'

  set laststatus=2
  set cursorline
  set shiftround

  set colorcolumn=80,+1

  " search and navigation
  set incsearch ignorecase smartcase nohlsearch

  " terminal settings
  set hidden lazyredraw
  set encoding=utf-8 shell=/bin/zsh title hidden ttyfast visualbell
  set t_ut=
  " disable BCE

  " fill chars
  set listchars=tab:>-,eol:$,precedes:<,extends:>,trail:~,conceal:#,nbsp:_
  set fillchars=vert:\│,fold:-
  set diffopt=iwhite

  " misc
  set backspace=indent,eol,start
  set scrolloff=7 scrolljump=4
  set virtualedit="all,onemore"
  set display=lastline

  " tab-expansion configuration
  set wildmenu wildmode=list:longest,list:full wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store

  set autoindent
  set expandtab smarttab tabstop=4 softtabstop=4 shiftwidth=4 nowrap
  set wrapmargin=0

  " modeline overrides default options
  set modeline modelines=10 noshowmode

  " undo, history, and persistent views
  sil !mkdir -p ~/.vim_temp/{backup,cache,undo,views}

  set noswapfile
  set backup backupdir=~/.vim_temp/backup//
  set undofile undolevels=10000 undodir=~/.vim_temp/undo//
  set viewdir=~/.vim_temp/views//

" }-
" bundles {+
  " vim-plug configuration {+
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall | source $MYVIMRC
    endif

    call plug#begin(expand('~/.vim/bundle/'))
    " let g:plug_window='horizontal bottomright new'
  " }-
  " core bundles {+
    " tommcdo plugins {+
      Plug 'tommcdo/vim-ninja-feet'
      Plug 'tommcdo/vim-text-objects'
    " }-
    " tpope plugins {+
      Plug 'tpope/vim-dispatch'
      Plug 'tpope/vim-eunuch'
      " Plug 'tpope/vim-fugitive'
      Plug 'juneedahamed/vc.vim'
      Plug 'tpope/vim-obsession'
      Plug 'tpope/vim-repeat'
      Plug 'tpope/vim-speeddating'
      Plug 'tpope/vim-surround'
      Plug 'tpope/vim-unimpaired'
    " }-
    " shougo plugins {+
      Plug 'Shougo/neocomplete' " depends on lua, which isn't always available
      Plug 'Shougo/neosnippet',              {'depends': ['honza/vim-snippets', 'Shougo/neosnippet-snippets']} " snippets {{{
      Plug 'Shougo/neosnippet-snippets'
      Plug 'Shougo/unite.vim',               {'depends': ['Shougo/vimproc.vim']}
      Plug 'Shougo/vimfiler'
      " {+
          let g:vimfiler_as_default_explorer = 1
      " }-
      Plug 'Shougo/vimproc.vim',             {'do': 'make'}
      Plug 'Shougo/vimshell.vim'
      " unite plugins {+
        Plug 'osyo-manga/unite-filetype'
        Plug 'osyo-manga/unite-fold'
        Plug 'osyo-manga/unite-quickfix'
        " PlugLazy 'osyo-manga/vim-snowdrop',   {'autoload': {'unite_sources': 'snowdrop'}}
        Plug 'tacroe/unite-mark'
        Plug 'thinca/vim-unite-history'
        Plug 'tsukkee/unite-help'
        Plug 'ujihisa/unite-colorscheme'
        Plug 'ujihisa/unite-locate'
        Plug 'Shougo/neomru.vim'
        Plug 'Shougo/unite-outline'
      " }-
    " }-
    " productivity tools {+
      "Plug 'dbakker/vim-projectroot'
      Plug 'airblade/vim-rooter'
      Plug 'mbbill/undotree',                {'on': 'UndotreeToggle'}
      " Plug 'ludovicchabant/vim-gutentags'
      Plug 'majutsushi/tagbar' " ,           {'on': 'TagbarToggle'}
    " }-
    " version control plugins {+
      " Plug 'tommcdo/vim-fugitive-blame-ext', {'depends': 'tpope/vim-fugitive'}
      " Plug 'gregsexton/gitv',                {'depends': 'tpope/vim-fugitive'}
    " }-
    " code and tab completion {+
      Plug 'tomtom/tlib_vim'
      Plug 'MarcWeber/vim-addon-mw-utils'
      Plug 'honza/vim-snippets'
      Plug 'garbas/vim-snipmate'
      Plug 'scrooloose/syntastic'
      Plug 'honza/vim-snippets'
    " }-
    " text navigation and alignment {+
      Plug 'Lokaltog/vim-easymotion'
      Plug 'bkad/CamelCaseMotion'
      Plug 'michaeljsmith/vim-indent-object'
      Plug 'vim-scripts/argtextobj.vim'
      Plug 'guns/vim-sexp'
      Plug 'terryma/vim-multiple-cursors'
      Plug 'tpope/vim-sleuth'
    " }-
    " junegunn {+
      Plug 'junegunn/vim-easy-align'
    " }-
    " keys and external bindings {+
      " Plug 'benmills/vimux' " unused?
      " Plug 'mhinz/vim-tmuxify' " unused?
      Plug 'justinmk/vim-gtfo'
      Plug 'christoomey/vim-tmux-navigator'
    " }-
    Plug 'chrisbra/NrrwRgn'
  " }-
  " color and visual bundles {+
    " color schemes {+
      Plug 'morhetz/gruvbox'
      Plug 'NLKNguyen/papercolor-theme'
      Plug 'junegunn/seoul256.vim'
      Plug 'sjl/badwolf'
      Plug 'trapd00r/neverland-vim-theme'
      Plug 'w0ng/vim-hybrid'
      Plug 'wellsjo/wells-colorscheme.vim'
    " }-
    " gui-only colorschemes {+
      Plug 'chriskempson/base16-vim',       {'on': []}
      if has('gui_running') | call plug#load('base16-vim') | endif
    " }-
    " visual indicators {+
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'
      Plug 'edkolev/tmuxline.vim',          {'on': []}
      if !has('gui_running') | call plug#load('tmuxline.vim') | endif
      Plug 'jacquesbh/vim-showmarks'
      Plug 'nathanaelkane/vim-indent-guides'
      Plug 'mhinz/vim-signify'
      Plug 't9md/vim-choosewin'
      Plug 'junegunn/goyo.vim',             {'on': 'Goyo'}
      Plug 'scrooloose/nerdtree',           {'on': 'NERDTreeToggle'}

      Plug 'ryanoasis/vim-webdevicons',     {'on': []}
      if has('gui_running') | call plug#load('vim-webdevicons') | endif
    " }-
    " additional syntax highlighting and matching {+
      Plug 'junegunn/rainbow_parentheses.vim'
      Plug 'chrisbra/Colorizer',            {'on': 'ColorToggle'}
      Plug 'junegunn/limelight.vim',        {'on': 'Limelight'}
      Plug 'jaxbot/semantic-highlight.vim', {'on': 'SemanticHighlightToggle'}
      Plug 'dimasg/vim-mark'
    " }-
  " }-
  " language-specific bundles {+
    " csv
    Plug 'chrisbra/csv.vim',                {'for': ['csv']}

    " haskell
    Plug 'ujihisa/neco-ghc',                {'for': ['h']}

    " hex
    Plug 'Shougo/vinarise.vim',             {'for': ['bin', 'xxd', 'hex']}

    " html
    Plug 'rstacruz/sparkup',                {'for': ['html', 'xml']}

    " java
    Plug 'sighforever/vim-syntastic-java-gradle-plugin', {'for': ['java']}

    " journal
    Plug 'junegunn/vim-journal',            {'for': ['journal']}

    " json
    Plug 'elzr/vim-json',                   {'for': ['json']}

    " markdown
    Plug 'nelstrom/vim-markdown-folding',   {'for': ['markdown', 'md', 'rst']}
    Plug 'suan/vim-instant-markdown',       {'for': ['markdown', 'md', 'rst']}

    " mediawiki
    Plug 'chikamichi/mediawiki.vim',        {'for': ['wiki', 'mediawiki']}

    " python
    Plug 'ivanov/vim-ipython',              {'for': ['python']}
    Plug 'nvie/vim-flake8',                 {'for': ['python']}
    Plug 'klen/python-mode',                {'for': ['python']}
    Plug 'davidhalter/jedi-vim',            {'for': ['python']}
    Plug 'tweekmonster/braceless.vim',      {'for': ['python']}

    " rust
    Plug 'wting/rust.vim',                  {'for': ['rust', 'rs']}

    " scala
    Plug 'derekwyatt/vim-scala',            {'for': ['scala']}
    Plug 'megaannum/vimside',               {'for': ['scala']} ", 'depends': ['Shougo/vimshell.vim', 'Shougo/vimproc.vim']

    " swift
    Plug 'toyamarinyon/vim-swift',          {'for': ['swift', 'playground']}

    " sql
    Plug 'vim-scripts/dbext.vim',           {'for': ['sql']}

    " vim
    Plug 'dbakker/vim-lint',                {'for': ['vim']}
  " }-
  call plug#end()
" }-
" bundle settings {+
  " airline {+
    let g:airline_powerline_fonts=1

    let g:airline#extensions#whitespace#enabled=0

    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#tabline#formatter='unique_tail_improved'

    let g:airline_mode_map={
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
  " }-
  " undotree {+
    "let g:gundo_preview_bottom=1
    let g:undotree_WindowLayout=2
    let g:undotree_TreeNodeShape="*"
  " }-
  " rainbow brackets {+
    let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']]
  " }-
  " syntastic {+
    " symbols
    let g:syntastic_check_on_open=1
    let g:syntastic_warning_symbol='>'
    let g:syntastic_error_symbol='x'
    let g:syntastic_style_error_symbol='*'
    let g:syntastic_style_warning_symbol='+'

    let g:syntastic_enable_highlighting=1
    let g:syntastic_stl_format='[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

    let g:syntastic_mode_map={"mode" : "active", "passive_filetypes" : []}

    " language-specific settings {+
      " c++ {+
        if executable('clang++')
          let g:syntastic_cpp_checkers=['gcc', 'clang_check']
          let g:syntastic_cpp_compiler='clang++'
          let g:syntastic_cpp_compiler_options=' -Wall -std=c++11-extensions -stdlib=libc++'
          let g:syntastic_clang_check_options=g:syntastic_cpp_compiler_options
          let g:syntastic_cpp_include_dirs=['/usr/local/include']
        elseif executable('g++')
          let g:syntastic_cpp_compiler='g++'
          let g:syntastic_cpp_compiler_options='-Wall -std=c++0x -stdlib=libc++'
        endif
      " }-
      " javascript {+
        let g:syntastic_javascript_checkers=['jsl']
      " }-
      " python {+
        autocmd FileType python setlocal omnifunc=jedi#completions
        let g:syntastic_mode_map.passive_filetypes=['python']

        let g:jedi#completions_enabled=0
        let g:jedi#auto_vim_configuration=0
        if !exists('g:neocomplete#force_omni_input_patterns')
          let g:neocomplete#force_omni_input_patterns = {}
        endif
        let g:neocomplete#force_omni_input_patterns.python =
        \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
        " alternative pattern: '\h\w*\|[^. \t]\.\w*'

        "let g:pymode_lint_write=0
        let g:pymode_virtualenv_enabled=1
      " }-
    " }-
  " }-
  " hardtime {+
    let g:hardtime_showmsg=1
    let g:hardtime_default_on=0
    let g:hardtime_ignore_quickfix=1
    let g:hardtime_ignore_buffer_patterns=["Unite","undo*","Help"]
  " }-
  " tmuxline {+
    let g:tmuxline_preset={
            \ 'a': '#S',
            \ 'b': '#F',
            \ 'win': '#I #W',
            \ 'cwin': '#I #W',
            \ 'z': '%R',
            \ 'options': {
                \'status-justify': 'left'
            \}
        \}
    "let g:tmuxline_preset='minimal'
  " }-
  " unite {+
    let g:unite_source_history_yank_enable=2
    let g:unite_enable_start_insert=1
    let g:unite_winwidth=10
    let g:unite_split_rule='botright'

    call unite#filters#matcher_default#use(['matcher_regexp'])
    call unite#filters#sorter_default#use(['sorter_selecta'])

    call unite#custom#profile('default', 'context', {
    \              'log' : 1,
    \ })
    call unite#custom#profile('source/colorscheme', 'context', {
    \     'auto_preview' : 1,
    \              'log' : 0,
    \     'start-insert' : 0,
    \   'prompt-visible' : 0,
    \ })
    call unite#custom#profile('source/line', 'context', {
    \      'buffer_name' : 'filter',
    \ 'prompt_direction' : 'below',
    \            'split' : 1,
    \              'tab' : 0,
    \           'prompt' : '&/',
    \           'toggle' : 1,
    \ })
    call unite#custom#source('source/line', 'matchers', 'matcher_regexp')

    " set fuzzy finder
    if !exists('g:finders') | let g:finders=['pt', 'ag', 'fzf', 'find'] | endif

    for finder in g:finders
      if !executable(finder)
        continue
      endif
      if finder == 'ag'
        set grepprg=ag\ --vimgrep\ $*
        set grepformat=%f:%l:%c:%m

        let g:unite_source_grep_command='ag'
        let g:unite_source_grep_default_opts='-i --line-numbers --nocolor --nogroup --hidden --ignore ".hg" --ignore ".svn" --ignore ".git" --ignore ".bzr"'
        let g:unite_source_grep_recursive_opt=''
        let g:unite_source_grep_encoding='utf-8'

        let g:unite_source_rec_async_command='ag --follow --nocolor --group --hidden -g ""'

        break
      elseif finder == 'pt'
        let g:unite_source_grep_command='pt'
        let g:unite_source_grep_default_opts='--nogroup --nocolor'
        let g:unite_source_grep_recursive_opt=''
        let g:unite_source_grep_encoding='utf-8'
      elseif finder == 'fzf'
        " TBD
        break
      elseif finder == 'find'
        " TBD
        break
      else
        echom "Unhandled finder ".finder." used. You\'re on your own."
        break
      endif
    endfor
  " }-
" }-
" keymapping {+
  " Rebind leader key
  let mapleader=' '

  " common bindings
  map Y y$

  " toggles
  nnor [toggle] <nop>
  nmap <leader>o [toggle]

  nnor [toggle]i :set list! list?<cr>
  nnor [toggle]n :set number! number?<cr>
  nnor [toggle]N :set relativenumber! relativenumber?<cr>
  nnor [toggle]v :set paste! paste?<cr>
  nnor [toggle]w :set wrap! wrap?<cr>

  "nnor [toggle]h :HardTimeToggle<cr>
  nnor [toggle]u :UndotreeToggle<cr>
  nnor [toggle]z :Goyo<cr>

  nnor j gj
  nnor k gk
  vnor j gj
  vnor k gk

  nnor n nzzzv
  nnor N Nzzzv
  nnor g; g;zz
  nnor g, g,zz

  " visual block reselect
  xnor < <gv
  xnor > >gv

  " nuke 'ex' mode
  nnor Q <nop>

  " super sudo write
  command! SudoWrite exec 'w !sudo tee % > /dev/null' | :e!
  cno w!! SudoWrite

  " CamelCaseMotion {+
    " map <silent> w <Plug>CamelCaseMotion_w
    " map <silent> b <Plug>CamelCaseMotion_b
    " map <silent> e <Plug>CamelCaseMotion_e
    " sunmap w
    " sunmap b
    " sunmap e

    " " overwrite behaviour for text objects
    " omap <silent> iw <Plug>CamelCaseMotion_iw
    " xmap <silent> iw <Plug>CamelCaseMotion_iw
    " omap <silent> ib <Plug>CamelCaseMotion_ib
    " xmap <silent> ib <Plug>CamelCaseMotion_ib
    " omap <silent> ie <Plug>CamelCaseMotion_ie
    " xmap <silent> ie <Plug>CamelCaseMotion_ie
  " }-
  " ChooseWin {+
    nmap <silent> <C-w>? <Plug>(choosewin)
    let g:choosewin_overlay_enable = 1
    let g:choosewin_overlay_shade = 1
  " }-
  " NeoComplete {+
    " Use neocomplete.
    let g:acp_enableAtStartup=0
    let g:neocomplete#enable_at_startup=1
    let g:neocomplete#data_directory='~/.vim/cache/neocomplete'
    " Use smartcase.
    let g:neocomplete#enable_smart_case=1
    let g:neocomplete#enable_fuzzy_completion=1

    " additional C++ sources
    if (!exists('g:neocomplete#sources#include#paths'))
      let g:neocomplete#sources#include#paths={}
      let g:neocomplete#sources#include#paths.cpp=""
    endif

    let g:neocomplete#sources#include#paths.cpp .= ".,/usr/local/include/"

    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
    let g:neosnippet#enable_snipmate_compatibility=1

    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()
    " inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

    imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
    smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""

  " }-
  " Unite {+
    " Unite leader key
    nnor [unite] <nop>
    nmap <leader>. [unite]

    " grep
    nnor <silent> [unite]/ :<C-u>Unite -buffer-name=results grep:.<cr>
    nnor <silent> [unite]w/ :<C-u>UniteWithCursorWord -buffer-name=results grep:.<cr>

    " Misc
    nnor <silent> [unite]? :<C-u>Unite -buffer-name=keymap mapping<cr>
    nnor <silent> [unite]b :<C-u>Unite -buffer-name=buffers buffer<cr>
    nnor <silent> [unite]" :<C-u>Unite -buffer-name=mark mark<cr>

    " CtrlP alternative
    nnor <silent>  :<C-u>Unite -buffer-name=files file_mru file_rec/async<cr>
    nnor <silent> [unite]gf :<C-u>UniteWithCursorWord -buffer-name=files file_rec/async<cr>
  " }-
  " vim-lion {+
    let g:lion_create_maps=1
    let g:lion_prompt='[/]: '
    vmap <Enter> <Plug>VLionLeft/
    vmap <S-Enter> <Plug>VLionRight/
  " }-
  " vim-mark {+
    let g:mwAutoLoadMarks=1
    let g:mwDefaultHighlightingPalette='maximum'

    " nmap * <Plug>MarkSearchGroupNext
    " nmap # <Plug>MarkSearchGroupPrev

  " }-
  " ShowMarks {+
    let g:showmarks_no_mappings=1
  " }-
" }-
" language-specific settings {+
  " set rust compiler
  au FileType rust if executable("rustc") | setlocal makeprg='rustc %' | endif

  " allow  = filter to use xmllint
  au FileType xml,html if executable("xmllint") | let &l:equalprg='xmllint --format --recover -' | endif

  " allow = filter to use python's json.tool
  au FileType json let &l:equalprg='python -m json.tool'

  " vim {+
  " TODO: change this to use augroups
    if &ft == 'vim'
      set path=~/.vim/bundle/
      set inex=strpart(v:fname,strridx(v:fname,'/')+1).'/README' " trim repo name
      set sua=.md,.txt,.markdown,.rst,.mdown
    endif
  " }-
" }-
" extended settings options {+
  let g:colorizer_auto_color=1
  let g:indent_guides_enable_on_vim_startup=0

  " local bundles should be added via ':PlugExtraEdit'
  if filereadable(glob("~/.local.vimrc"))
    so ~/.local.vimrc
  endif
" }-
" autocommands {+
  " au BufReadPost * if buftype == "" | Indent | endif
  au BufWritePre * if &buftype == "" | %s/\s\+$//e | endif   " trim trailing whitespace

  au BufWinLeave * if expand("%") != "" | mkview | endif
  au BufWinEnter * if expand("%") != "" | silent loadview | endif

" }-
exe "colorscheme ". g:colorscheme
filetype plugin indent on
syntax on
" I don't use modula, but I do use .md as a markdown extension.
if expand("%e:") == "md"  | set ft=markdown | endif

" If % is a logfile, I like to use 'dcl' highlighting rules
if expand("%:e") == "log|conf|out" | set ft=dcl | endif

" Spring files aren't recognized
if expand("%:e") == "spring" | set ft=xml | endif

" html/xml entity replacement {+
"augroup xml
"  syntax match xmlEntity "&quot;" conceal cchar="
"  syntax match xmlEntity "&amp;" conceal cchar=&
"  syntax match xmlEntity "&lt;" conceal cchar=<
"  syntax match xmlEntity "&gt;" conceal cchar=>
"  set cole=2
"  set concealcursor=nv
"augroup END
" ^ this makes my vim unhappy :(
" }-

function! s:DiskDiff()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiskDiff()
