set number
set showmode
set list
set listchars=tab:--
set listchars+=trail:◦
set autoindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set nobackup
set nowb
set noswapfile
set autoread
set cursorline
set laststatus=2

syntax on
syntax enable

" start pathoen
execute pathogen#infect()

" Yaml indenting
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" disable cursor keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Plugins
" call plug#begin('~/.vim/plugged')

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'scrooloose/nerdtree'

" call plug#end()

" NERDTree shortcut key
" " Nerd Tree
let NERDTreeDirArrows = 1
nmap <C-n> :NERDTreeToggle<CR>
set modifiable
