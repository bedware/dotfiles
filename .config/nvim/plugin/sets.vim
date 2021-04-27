" General
set encoding=utf-8
set title

set number
set relativenumber

set nowrap
set guicursor=
set nohlsearch
set incsearch
set termguicolors
set scrolloff=8
set colorcolumn=80

" Indents
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50