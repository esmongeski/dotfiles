set nocompatible

set rnu
set nu
set hlsearch
set incsearch

syntax enable
filetype plugin on

autocmd BufWritePre * :%s/\s\+$//e
