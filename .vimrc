execute pathogen#infect()
filetype plugin on
let g:go_fmt_command = "goimports"
set t_Co=256
set hlsearch
set background=dark
set smartcase
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
color molokai
syntax on
