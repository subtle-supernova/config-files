set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
lua require('init')

colorscheme oxocarbon

set guicursor=i:block
set noswapfile
