set number
set hlsearch
set background=dark
set smartcase
set t_Co=256
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
syntax on
color molokai
highlight Normal ctermbg=black
autocmd FileType ruby,eruby set ts=2 sw=2 sts=2 expandtab
autocmd FileType python set ts=4 sw=4 sts=4 expandtab 
