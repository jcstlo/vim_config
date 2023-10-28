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
call plug#end()

" --------------- Sets ---------------

set number
set relativenumber
set nowrap
set nowrapscan
set nohlsearch
set hidden
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
set noerrorbells
set belloff=all

" --------------- Colorscheme ---------------

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

" --------------- Maps ---------------

" vimrc
nnoremap <leader>vrc :tabe ~/.vimrc<CR>
nnoremap <leader>src :w<CR>:so %<CR>

" Directory navigation
nnoremap <leader>dir :Explore<CR>

" Buffers
nnoremap <leader>bl :buffers<CR>
nnoremap <leader>bs <C-^>

" Splits
nnoremap <leader>wl <C-w>v<C-w>l
nnoremap <leader>wj <C-w>s<C-w>j
nnoremap <silent> <leader><Right> :vertical resize -5<CR>
nnoremap <silent> <leader><Left> :vertical resize +5<CR>
nnoremap <silent> <leader><Up> :resize +5<CR>
nnoremap <silent> <leader><Down> :resize -5<CR>

" Yank entire file to clipboard
nnoremap <leader>ya ggVG"+y

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

" PLUGIN: fzf.vim keybindings
nnoremap <leader>ff :GFiles<CR>
nnoremap <leader>fg :RG<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fw :RG <C-R><C-W><CR>
nnoremap <leader>fa :Files<CR>
