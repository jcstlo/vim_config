" ======== WINDOWS GVIM CONFIG BEGIN ========

" NOTE: .vimrc file should be located at $HOME/_vimrc on windows
" Use ':echo $HOME' command in gVim to get full path

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

" ======== Sets ========
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
set nobackup
set nowb
set noswapfile
set colorcolumn=80
syntax on

" Disable annoying bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

if has ("gui_running")
    if has("gui_win32")
        set guifont=JetBrains_Mono:h12:W500:cANSI:qDRAFT
        " set guifont=Fira_Mono_Medium:h10:W500:cANSI:qDRAFT
    endif
endif

let mapleader = " "

" ======== Maps ========
" vimrc
nnoremap <leader>vrc :tabe $HOME/_vimrc<CR>
nnoremap <leader>src :w<CR>:so %<CR>

" Plugin-specific
nnoremap <C-e> :NERDTreeToggle<CR>

" Directory-related
nnoremap <leader>cms :cd $HOME/Desktop/Main_Sync/<CR>
nnoremap <leader>cdt :cd $HOME/Desktop/<CR>
nnoremap <leader>ch :cd $HOME<CR>

" Buffer-related
nnoremap <leader>bl :buffers<CR>
nnoremap <leader>bs <C-^>

" Splits
nnoremap <leader>wl <C-w>v<C-w>l
nnoremap <leader>wj <C-w>s<C-w>j

nnoremap <leader>w, :vertical resize -5<CR>
nnoremap <leader>w< :vertical resize -20<CR>

nnoremap <leader>w. :vertical resize +5<CR>
nnoremap <leader>w> :vertical resize +20<CR>

nnoremap <leader>w= :resize +5<CR>
nnoremap <leader>w- :resize -5<CR>

" Other
nnoremap <leader>td o- [ ] 
nnoremap <leader>ya ggVG"+y

" Place cursor where font size is in _vimrc
nmap <leader>fs <leader>vrc0gg/guifont<CR>0f:ll

" Automatic font size changes
nmap <leader>8fs <leader>fscw8<Esc><leader>src:q<CR>
nmap <leader>9fs <leader>fscw9<Esc><leader>src:q<CR>
nmap <leader>10fs <leader>fscw10<Esc><leader>src:q<CR>
nmap <leader>11fs <leader>fscw11<Esc><leader>src:q<CR>
nmap <leader>12fs <leader>fscw12<Esc><leader>src:q<CR>
nmap <leader>13fs <leader>fscw13<Esc><leader>src:q<CR>
nmap <leader>14fs <leader>fscw14<Esc><leader>src:q<CR>

" ======== WINDOWS GVIM CONFIG END ========
