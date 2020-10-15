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
set title
set backspace=indent,eol,start
set t_Co=256
set modifiable

syntax on
syntax enable

" start pathogen
execute pathogen#infect()
filetype plugin indent on


" Yaml indenting
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" disable cursor keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Plugins
" call plug#begin('~/.vim/plugged')

let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_x = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline_section_b = '%{FugitiveStatusline()}'
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
let g:airline_theme='jellybeans'


" NERDTree shortcut key
" " Nerd Tree
let NERDTreeDirArrows = 1
nmap <C-n> :NERDTreeToggle<CR>
