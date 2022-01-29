syntax on
set showmatch
set ignorecase
set hlsearch
set tabstop=4
set shiftwidth=4
set autoindent
set clipboard=unnamedplus
set number
set relativenumber
set cursorline
set noswapfile
" set mouse=a


" -- Plugins 
"
call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'tomasiser/vim-code-dark'

" -- LSP
Plug 'https://github.com/neovim/nvim-lspconfig'

call plug#end()

" -- Lua configs



" -- Colour scheme
colorscheme codedark
