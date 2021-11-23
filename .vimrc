filetype off
set shellslash
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin('~/vimfiles/bundle')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" All of your Plugins must be added before the following line
Plugin 'morhetz/gruvbox'
Plugin 'itchyny/lightline.vim'
Plugin 'preservim/nerdtree'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let g:gruvbox_contrast_dark='hard'
autocmd vimenter * ++nested colorscheme gruvbox

set number
set relativenumber
set nowrap
set background=dark
set nohlsearch
set hidden
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set incsearch
set scrolloff=8
set laststatus=2
set noshowmode
set wildmenu
set backspace=indent,eol,start
syntax on

" Disable annoying bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

if has ("gui_running")
    if has("gui_win32")
        " set guifont=Fira_Mono_Medium:h10:W500:cANSI:qDRAFT
        set guifont=JetBrains_Mono:h8:W500:cANSI:qDRAFT
    endif
endif

let mapleader = " "

" Macros
" nnoremap <leader>vrc :tabe ((PATH TO VIMRC))<CR> 
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <leader>src :so %<CR>
