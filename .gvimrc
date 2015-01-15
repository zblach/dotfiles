" .gvimrc - zblach 2013
" vim: set foldmarker={{{,}}} foldmethod=marker tabstop=2 nospell
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set guioptions=agit
let g:colorscheme='base16-monokai'

if filereadable(glob("~/.local.gvimrc"))
    so ~/.local.gvimrc
endif

