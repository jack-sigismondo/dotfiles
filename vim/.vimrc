" interchangeable with vim/neovim
" run update-vimrc.sh whenever you make updates to share this same file with
" legacy vim

set nocompatible
set nomodeline " for security


" VIMWIKI
" installation:
" git clone https://github.com/vimwiki/vimwiki.git ~/.vim/pack/plugins/start/vimwiki
" # to generate documentation i.e. ':h vimwiki'
" vim -c 'helptags ~/.vim/pack/plugins/start/vimwiki/doc' -c quit
let g:vimwiki_list = [{'path': '~/Notes/vimwiki/',
			\ 'syntax': 'markdown', 'ext':'md',
			\ 'diary_rel_path': 'entries/',}]
let g:vimwiki_global_ext = 0


" CLIENT
set autoread
set autowrite " write file on :next, :make and more
set autowriteall 
set novisualbell
colorscheme desert


" TAGS
" on a buffer's write create ctags ; .xyz can be added on a whim
au BufWritePost *.c,*.cpp,*.h,*.py,*.js silent! !ctags -R 2> /dev/null &


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
set equalalways
set tabstop=4
set shiftwidth=4
" set expandtab " changes tabs into spaces
" set autocomplete " doesn't play nice with neovim


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
" inoremap kj <Esc>
" inoremap kkj k<Esc>
" inoremap kjk k<Esc>

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
