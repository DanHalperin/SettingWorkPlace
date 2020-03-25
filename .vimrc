set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'sonph/onehalf', {'rtp': 'vim/'}
Plugin 'rakr/vim-one'
Plugin 'itchyny/lightline.vim'
Plugin 'flazz/vim-colorschemes'
call vundle#end()

filetype plugin indent on

set number
set showcmd
set incsearch
set hlsearch
set backspace=indent,eol,start
set laststatus=2
set noshowmode
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [ []<Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i
set mouse=a
syntax on
:set t_ut=""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


set termguicolors
let g:airline_theme='molokai'
colorscheme  wombat256mod
set background=dark

syntax enable
set t_Co=256


setlocal tabstop=4
setlocal shiftwidth=4
