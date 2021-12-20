call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'kovisoft/slimv' 

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
set bg=light
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab

set encoding=utf-8
scriptencoding utf-8
set list
set listchars=tab:»·,trail:·

set backspace=indent,eol,start
set ignorecase
set smartcase
set incsearch
set hlsearch
set backup
set backupdir^=~/.vim/_backup//
set directory^=~/.vim/_temp//
set autoindent
set smartindent
set showmatch
set number
set relativenumber
set t_Co=256

let g:rustfmt_autosave = 1
let g:ycm_always_populate_location_list = 1

au VimEnter clj RainbowParenthesesToggle
au Syntax clj RainbowParenthesesLoadRound
au Syntax clj RainbowParenthesesLoadSquare
au Syntax clj RainbowParenthesesLoadBraces

let g:syntastic_python_flake8_post_args='--ignore=D203,E501,E221,E201,E402,E241,E226,E261,E265'

let g:ycm_semantic_triggers = {
\ 'elm' : ['.'],
\}

set termguicolors
colorscheme summerfruit256
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
let g:slimv_swank_cmd = "!ros -e '(ql:quickload :swank) (swank:create-server)' wait &"
let g:slimv_lisp = 'ros run'
let g:slimv_impl = 'ccl'

