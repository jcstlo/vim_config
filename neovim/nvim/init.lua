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

-- ------------------- Maps (built-in) -------------------

-- vimrc
vim.keymap.set("n", "<leader>vrc", ":tabe $MYVIMRC<CR>", { silent = false })
vim.keymap.set("n", "<leader>src", ":w<CR>:so %<CR>", { silent = false })

-- directory navigation
vim.keymap.set("n", "<leader>dir", ":Explore<CR>", { silent = false })

-- buffers
vim.keymap.set("n", "<leader>bl", ":buffers<CR>:b<space>", { silent = false })
vim.keymap.set("n", "<leader>bs", "<C-^>", { silent = false })

-- splits
vim.keymap.set("n", "<leader>wl", "<C-w>v<C-w>l", { silent = false })
vim.keymap.set("n", "<leader>wj", "<C-w>s<C-w>j", { silent = false })
vim.keymap.set("n", "<C-l>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", ":vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":resize -2<CR>", { silent = true })

-- yank entire file to clipboard
vim.keymap.set("n", "<leader>ya", "ggVG\"+y", { silent = true })

-- more ergonomic maps for paste and visual yank
vim.keymap.set("n", "<leader>p", "\"+p", { silent = true })
vim.keymap.set("v", "<leader>y", "\"+y", { silent = true })

-- [R]elative-number [E]nable / [D]isable
vim.keymap.set("n", "<leader>rd", ":set nornu<CR>", { silent = true })
vim.keymap.set("n", "<leader>re", ":set rnu<CR>", { silent = true })

-- Word wrap enable/disable
vim.keymap.set("n", "<leader>wr", ":set wrap<CR>", { silent = false })
vim.keymap.set("n", "<leader>WR", ":set wrap linebreak breakindent<CR>", { silent = false })
vim.keymap.set("n", "<leader>nowr", ":set nowrap nolinebreak breakindent<CR>", { silent = false })

-- Remove trailing whitespace in current file
vim.keymap.set("n", "<leader>rws", ":%s/\\s\\+$//e<CR>", { silent = true })

-- for accidental uppercase when saving/exiting Vim
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

-- remove search highlight, until next search
vim.keymap.set("n", "<leader>h", ":noh<CR>", { silent = true })

-- search for current visual selection
vim.keymap.set("v", "//", "y/\\V<C-R>=escape(@\",'/\')<cr><cr>", { silent = true })

-- ------------------- Plugins -------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    "nvim-lualine/lualine.nvim",
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope.nvim", version = "*" },
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    { "mason-org/mason-lspconfig.nvim", opts = {}, },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "retrobox" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

vim.cmd.colorscheme("retrobox")

require('lualine').setup()

require('gitsigns').setup()

-- telescope
require('telescope').setup()
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- lsp
require('mason').setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "rust_analyzer",
        "lua_ls",
    },
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics", })

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = false,
      })
      vim.keymap.set("i", "<C-Space>", function() vim.lsp.completion.get() end)
    end
  end,
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        -- this disables the annoying undefined global warning in my init.lua
        globals = { "vim" },
      },
    },
  },
})
