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

" Autowrite a new html file on file write using pandoc
au BufWritePost ~/Notes/vimwiki/*.md silent! :! pandoc -s --from=markdown+hard_line_breaks
			\ '%' -o ~/Notes/html/'%:t:r'.html
" and keep a local only copy too
au BufWritePost ~/Notes/vimwiki/*.md silent! :! cp '%' ~/Notes/rough/vimwiki/'%:t'

" CLIENT
set autoread
set autowrite " Write file on :next, :make and more
set autowriteall 
set novisualbell
" colorscheme desert

" TAGS
" on a buffer's write create ctags ; .xyz can be added on a whim
" au BufWritePost *.c,*.cpp,*.h,*.py,*.js silent! !ctags -R 2> /dev/null &


" FORMATTING
filetype plugin indent on " Should be all inclusive
syntax on
set autoindent
set smartindent
" set cursorline
set number
set numberwidth=3 " Consistent spacing
set relativenumber 
set wrap
" set linebreak
set textwidth=80
set equalalways
set tabstop=4
set shiftwidth=4
" set expandtab " changes tabs into spaces
" set autocomplete " doesn't play nice with neovim
set showmatch


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

set mouse=nvi " Middle click to paste

let mapleader = " "
nnoremap <Leader>b :buffer 
nnoremap <Leader>f :find 

" Move windows with control
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move between buffers with shift
nnoremap H :bp<CR>
nnoremap L :bn<CR>

" Move and focus searches in Vimwiki
autocmd FileType markdown nnoremap <C-p> :lprev<CR>zz
autocmd FileType markdown nnoremap <C-n> :lnext<CR>zz

" Switch to vifm and open 
" LAUNCH VIFM WITH EXTRA PATH TO CUSTOM VIM CONFIG and current path
" TODO try :explore
function! ViFM()
	echo $PWD
endfunction
" nnoremap <Leader>e :call ViFM()<CR>
"
"

" File browser
nnoremap <Leader>e :Lexplore<CR>
