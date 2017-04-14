#!/bin/sh

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
git clone git://github.com/tpope/vim-sleuth.git ~/.vim/bundle/vim-sleuth
