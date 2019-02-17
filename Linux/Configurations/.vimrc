"
" Plugins managed by vim-plug
"
call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
call plug#end()

"
" General
"
syntax on			" Enable syntax highlight
let g:onedark_terminal_italics=1
colorscheme onedark

set relativenumber	" Show relative line numbers
set linebreak		" Break lines at word (requires Wrap lines)
set showmatch		" Highlight matching brace
 
set hlsearch		" Highlight all search results
set smartcase		" Enable smart-case search
 
set autoindent		" Auto-indent new lines
set tabstop=4
set shiftwidth=4
set smartindent		" Enable smart-indent

set clipboard=unnamedplus

"
" Advanced 
"
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start
