-- --------------------------------------------------------------------------
-- jcstlo's neovim config
-- --------------------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = "\\" -- for lazy.nvim

-- ------------------- Sets -------------------

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- word wrap off
vim.opt.wrap = false
vim.opt.wrapscan = false

-- enable highlights when searching
vim.opt.hlsearch = false

-- freedom to fly through buffers
vim.opt.hidden = true

-- indent related
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true   -- spaces > tabs
vim.opt.autoindent = true  -- indent next line based on current line
vim.opt.smartindent = true -- indent next line based on language

-- no need for backups or swapfiles
vim.opt.backup = false
vim.opt.wb = false
vim.opt.swapfile = false

-- misc
vim.opt.incsearch = true -- show pattern match as I'm searching
vim.opt.scrolloff = 8    -- keep some lines above/below cursor when scrolling
vim.opt.laststatus = 2   -- always have status line
vim.opt.showmode = false -- status line plugin shows which mode I'm in
vim.opt.wildmenu = true  -- suggestions with <Tab> in command mode

-- ------------------- WSL clipboard support -------------------

vim.cmd([[
    set clipboard+=unnamedplus
    let g:clipboard = {
                \   'name': 'WslClipboard',
                \   'copy': {
                \      '+': 'clip.exe',
                \      '*': 'clip.exe',
                \    },
                \   'paste': {
                \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \   },
                \   'cache_enabled': 0,
                \ }
]])

-- ------------------- Maps (built-in) -------------------

-- template:
-- vim.api.nvim_set_keymap(MODE, SHORTCUT, COMMAND, { noremap = true/false, silent = true/false })

-- vimrc
vim.api.nvim_set_keymap("n", "<leader>vrc", ":tabe $MYVIMRC<CR>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>src", ":w<CR>:so %<CR>", { noremap = true, silent = false })

-- directory navigation
vim.api.nvim_set_keymap("n", "<leader>dir", ":Explore<CR>", { noremap = true, silent = false })

-- buffers
vim.api.nvim_set_keymap("n", "<leader>bl", ":buffers<CR>:b<space>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>bs", "<C-^>", { noremap = true, silent = false })

-- splits
vim.api.nvim_set_keymap("n", "<leader>wl", "<C-w>v<C-w>l", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>wj", "<C-w>s<C-w>j", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-l>", ":vertical resize -5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-h>", ":vertical resize +5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":resize +5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":resize -5<CR>", { noremap = true, silent = true })

-- yank entire file to clipboard
vim.api.nvim_set_keymap("n", "<leader>ya", "ggVG\"+y", { noremap = true, silent = true })

-- more ergonomic maps for paste and visual yank
vim.api.nvim_set_keymap("n", "<leader>p", "\"+p", { noremap = false, silent = true })
vim.api.nvim_set_keymap("v", "<leader>y", "\"+y", { noremap = false, silent = true })

-- [R]elative-number [E]nable / [D]isable
vim.api.nvim_set_keymap("n", "<leader>rd", ":set nornu<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>re", ":set rnu<CR>", { noremap = true, silent = true })

-- Word wrap enable/disable
vim.api.nvim_set_keymap("n", "<leader>wr", ":set wrap<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>WR", ":set wrap linebreak<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>nowr", ":set nowrap nolinebreak<CR>", { noremap = true, silent = true })

-- Remove trailing whitespace in current file
vim.api.nvim_set_keymap("n", "<leader>rws", ":%s/\\s\\+$//e<CR>", { noremap = true, silent = true })

-- for accidental uppercase when saving/exiting Vim
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

-- create timestamp in [HH:MM AM/PM] format, for plain text logging
vim.api.nvim_set_keymap("n", "<leader>ts", "i<C-R>=strftime(\"[%I:%M %p]\")<CR><Esc>a ", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ots", "o<CR><Esc>i<C-R>=strftime(\"[%I:%M %p]\")<CR><Esc>o<CR>", { noremap = false, silent = true })

-- remove search highlight, until next search
vim.api.nvim_set_keymap("n", "<leader>h", ":noh<CR>", { noremap = false, silent = true })

-- search for current visual selection
vim.api.nvim_set_keymap("v", "//", "y/\\V<C-R>=escape(@\",'/\')<cr><cr>", { noremap = true, silent = true })

-- ------------------- Separate config files -------------------

require("config.lazy")
require("config.lualine")
require("config.gitsigns")
require("config.telescope")
require("config.lsp")
require("config.colorschemes")
require("config.leap")
