set number
set relativenumber
set nowrap
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

" WSL SPECIFIC SET
set clipboard=unnamedplus 

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

call plug#begin()

" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
" Telescope + dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'joshdick/onedark.vim'

" Initialize plugin system
call plug#end()

syntax on
colorscheme onedark
" ======== Maps ========

let mapleader = " "

" vimrc
nnoremap <leader>vrc :tabe $HOME/_vimrc<CR>
nnoremap <leader>vrc :tabe ~/.config/nvim/init.vim<CR>
nnoremap <leader>src :w<CR>:so %<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Buffer-related
nnoremap <leader>bl :buffers<CR>
nnoremap <leader>bs <C-^>

" Splits
nnoremap <leader>wl <C-w>v<C-w>l
nnoremap <leader>wj <C-w>s<C-w>j

noremap <silent> <C-Right> :vertical resize -5<CR>
noremap <leader>w< :vertical resize -20<CR>

nnoremap <silent> <C-Left> :vertical resize +5<CR>
nnoremap <leader>w> :vertical resize +20<CR>

nnoremap <silent> <C-Up> :resize +5<CR>
nnoremap <silent> <C-Down> :resize -5<CR>

" Other
nnoremap <leader>td o- [ ] 
nnoremap <leader>cap :e $HOME/capture.txt<CR>
nnoremap <leader>ya ggVG"+y
