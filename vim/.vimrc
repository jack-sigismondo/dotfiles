" interchangeable with vim/neovim

set nocompatible
set nomodeline " for security


" NEOVIM
if has ('nvim')
	set termguicolors
	set completeopt+=fuzzy
	colorscheme desert " sorbet unokai zaibatsu habamax slate unokai 
endif


" CLIENT
set autoread
set autowrite " write file on :next, :make and more
set autowriteall 
set novisualbell


" FORMATTING
filetype plugin indent on " should be all inclusive
syntax on
set autoindent
set smartindent
set cursorline
set number
set relativenumber 
set wrap
set linebreak
set textwidth=80
set autocomplete
set equalalways
set tabstop=4
set shiftwidth=4
" set expandtab " changes tabs into spaces

" SEARCH
set incsearch
set hlsearch
set ignorecase
set smartcase

" FIND
set path+=**
set wildmenu
" set wildmode=list:longest,full


" INPUT
inoremap jk <Esc>
inoremap kj <Esc>

set mouse=nvi " middle click to paste

let mapleader = " "
nnoremap <Leader>b :buffer 
nnoremap <Leader>f :find 

nnoremap <Leader>v <C-w>v
nnoremap <Leader>s <C-w>s
nnoremap <Leader>q <C-w>q

nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
