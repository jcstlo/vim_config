vim.g.mapleader = ' '

-- ---------
-- SETS
-- ---------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.wrapscan = false
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.wildmenu = true
vim.opt.backspace="indent,eol,start"
vim.opt.backup = false
vim.opt.wb = false
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"

-- TEMPORARY: VIM COMMAND WRAPPER FOR TRUE COLOR SUPPORT
vim.cmd([[
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
]])

-- vim-plug start. TEMPORARY, might move to packer.nvim soon
-- IMPORTANT: Need different syntax when plugins require arguments 'for' and 'do' 
    -- See vonheikemen's article on using vim-plug in lua
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')
-- The default plugin directory will be as follows:
--   - Vim (Linux/macOS): '~/.vim/plugged'
--   - Vim (Windows): '~/vimfiles/plugged'
--   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
-- You can specify a custom plugin directory by passing it as the argument
--   - e.g. `call plug#begin('~/.vim/plugged')`
--   - Avoid using standard Vim directory names like 'plugin'

-- Make sure you use single quotes
-- Telescope + dependencies
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', {
    ['do'] = function()
        vim.call('cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build')
    end
})
Plug('nvim-treesitter/nvim-treesitter', {
    ['do'] = function()
        vim.call(':TSUpdate')
    end
})
Plug 'kyazdani42/nvim-web-devicons'
Plug('nvim-telescope/telescope.nvim', {tag = '0.1.0'})

-- Other plugins
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'

-- Initialize plugin system
vim.call('plug#end')
-- vim-plug end

-- vim.cmd('syntax on') -- syntax is on automatically
vim.cmd('colorscheme onedark')

-- ---------
-- MAPS
-- ---------

-- Map Functions
function map(mode, shortcut, command, _silent, _nore)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = _nore, silent = _silent })
end

function nnoremap(shortcut, command)
    map('n', shortcut, command, true, false)
end

function nnoremap_silent(shortcut, command)
    map('n', shortcut, command, true, true)
end

-- vimrc
nnoremap("<leader>vrc", ":tabe ~/.config/nvim/init.lua<CR>")
nnoremap("<leader>src", ":w<CR>:so %<CR>")

-- Open :Explore
nnoremap("<leader>dir", ":Explore<CR>")

-- Find file using Telescope command-line sugar.
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")

-- Buffer-related
nnoremap("<leader>bl", ":buffers<CR>")
nnoremap("<leader>bs", "<C-^>")

-- Splits
nnoremap("<leader>wl", "<C-w>v<C-w>l")
nnoremap("<leader>wj", "<C-w>s<C-w>j")

nnoremap_silent("<C-Right>", ":vertical resize -5<CR>")
nnoremap_silent("<C-Left>", ":vertical resize +5<CR>")
nnoremap_silent("<C-Up>", ":resize +5<CR>")
nnoremap_silent("<C-Down>", ":resize -5<CR>")

-- Other
nnoremap("<leader>td", "o- [ ] ")
nnoremap("<leader>cap", ":e $HOME/capture.txt<CR>")
nnoremap("<leader>ya", 'ggVG"+y')
