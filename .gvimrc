" .gvimrc - zblach 2013
" vim: set foldmarker={{{,}}} foldmethod=marker tabstop=2 nospell
set guioptions=agitm
let g:colorscheme='base16-monokai'
let &guifont='Menlo Regular for Powerline:h11'

if filereadable(glob("~/.local.gvimrc"))
    so ~/.local.gvimrc
endif

