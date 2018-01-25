call plug#begin('~/.vim/plugged')
Plug 'flazz/vim-colorschemes'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'

Plug 'elixir-lang/vim-elixir'
Plug 'rust-lang/rust.vim'
Plug 'keith/swift.vim'
Plug 'tpope/vim-fireplace'
Plug 'kien/rainbow_parentheses.vim'
Plug 'reasonml-editor/vim-reason'
Plug 'ElmCast/elm-vim'
call plug#end()

set nocp

set mouse=
colorscheme solarized
set bg=light
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
"set list
set backspace=indent,eol,start
set ignorecase
set smartcase
set incsearch
set hlsearch
"set backupdir^=~/.vim/_backup//
set directory^=~/.vim/_temp//
set autoindent
set smartindent
set showmatch
set number

"let g:ycm_rust_src_path = '/usr/local/rustc/src'
let g:ycm_rust_src_path = '~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"let g:syntastic_python_checker_args='--ignore=D203,E501,E221,E201,E402,E241,E226,E261'
let g:syntastic_python_flake8_post_args='--ignore=D203,E501,E221,E201,E402,E241,E226,E261,E265'

let g:ycm_semantic_triggers = {
\ 'elm' : ['.'],
\}
