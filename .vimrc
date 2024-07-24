" --------------------------------------------------------------------------
" jcstlo's basic vim config
" --------------------------------------------------------------------------
"
"   Focuses on using built-in Vim features, and only pulling in stable
" plugins that are either essential to my workflow or visual QoL
" improvements.
"
"   Why? I want to have a stable, easy-to-install config to fall back on,
" as I work my way around learning Neovim configuration in Lua (probably
" breaking things along the way)
"
" --------------------------------------------------------------------------
" Recommendations for installing this configuration from scratch:
"   0) Open a new file: ~/.vimrc
"   1) Start with built-in sets and maps
"   2) Install vim-plug package manager
"   3) Install plugins and add plugin-related maps (noted with "PLUGIN:")
"   4) Configure colorscheme

let mapleader = " "

" --------------- Plugins ---------------
" Refer to https://github.com/junegunn/vim-plug for details

call plug#begin()
Plug 'joshdick/onedark.vim'                         " onedark colorscheme
Plug 'sainnhe/sonokai'                              " sonokai colorscheme
Plug 'itchyny/lightline.vim'                        " status line
Plug 'jiangmiao/auto-pairs'                         " auto-close pairs, like (), {}, [], '', etc
Plug 'Yggdroot/indentLine'                          " visual indication for indents
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy finder
Plug 'junegunn/fzf.vim'                             " fuzzy finder
Plug 'airblade/vim-gitgutter'                       " changed git file indication
Plug 'tpope/vim-fugitive'                           " git wrapper
Plug 'easymotion/vim-easymotion'                    " easier cursor jumps
call plug#end()

" --------------- Sets ---------------

" line numbers
set number
set relativenumber

" default to word wrap off
set nowrap
set nowrapscan

" no highlights when searching
set nohlsearch

" freedom to fly through buffers
set hidden

" indent-related
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab   " spaces > tabs
set autoindent  " indent next line based on current line
set smartindent " indent next line based on language

" no need for backups or swapfiles
set nobackup
set nowb
set noswapfile

" disable annoying sounds
set noerrorbells
set belloff=all

" misc
set incsearch                  " show pattern match as I'm searching
set scrolloff=8                " keep some lines above/below cursor when scrolling
set laststatus=2               " always have status line
set noshowmode                 " status line plugin already shows which mode I'm in
set wildmenu                   " suggestions with <Tab> in command mode
set backspace=indent,eol,start " backspace works on everything in insert mode

" --------------- Colorscheme ---------------

" ---- Recommended color support code from onedark.vim README ----
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
let g:sonokai_style = 'andromeda'
colorscheme sonokai
" colorscheme onedark

" --------------- Maps - Built-in ---------------

" vimrc
nnoremap <leader>vrc :tabe ~/.vimrc<CR>
nnoremap <leader>src :w<CR>:so %<CR>

" Directory navigation
nnoremap <leader>dir :Explore<CR>

" Buffers
nnoremap <leader>bl :buffers<CR>:b<space>
nnoremap <leader>bs <C-^>

" Splits
nnoremap <leader>wl <C-w>v<C-w>l
nnoremap <leader>wj <C-w>s<C-w>j
nnoremap <silent> <C-l> :vertical resize -5<CR>
nnoremap <silent> <C-h> :vertical resize +5<CR>
nnoremap <silent> <C-k> :resize +5<CR>
nnoremap <silent> <C-j> :resize -5<CR>

" Select entire file
nnoremap <leader>va ggVG

" [R]elative-number [E]nable / [D]isable
nnoremap <leader>rd :set nornu<CR>
nnoremap <leader>re :set rnu<CR>

" Word wrap enable/disable
nnoremap <leader>wr :set wrap<CR>
nnoremap <leader>WR :set wrap linebreak<CR>
nnoremap <leader>nowr :set nowrap nolinebreak<CR>

" Remove trailing whitespace in current file
nnoremap <leader>rws :%s/\s\+$//e<CR>

" for accidental uppercase when saving/exiting Vim
:command WQ wq
:command Wq wq
:command W w
:command Q q

" --------------- Maps - Plugins ---------------

" PLUGIN: fzf.vim
nnoremap <leader>ff :GFiles<CR>
nnoremap <leader>fg :RG<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fw :RG <C-R><C-W><CR>
nnoremap <leader>fa :Files<CR>

" PLUGIN: vim-fugitive
nnoremap <leader>gb :Git blame<CR>
vnoremap <leader>gb :Git blame<CR>

" PLUGIN: easymotion
let g:EasyMotion_do_mapping = 0
nmap <leader>j <Plug>(easymotion-s2)
