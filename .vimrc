set nocompatible

set rnu
set nu

syntax enable
filetype plugin on

autocmd BufWritePre * :%s/\s\+$//e
