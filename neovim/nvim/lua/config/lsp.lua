-- LSP configuration
vim.opt.signcolumn = "yes"

-- Mason stuff
require("mason").setup()
require("mason-lspconfig").setup{
    ensure_installed = { "eslint", "ts_ls", "lua_ls", "pylsp", "tailwindcss", "clangd", "gopls" },
}

-- Add cmp_nvim_lsp capabilities settings to lspconfig
local lspconfig = require("lspconfig")
lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
    "force",
    lspconfig.util.default_config.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- Execute this callback function every time a language server
-- is attached to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  end,
})

-- Set up installed language servers here
local nvim_lsp = require('lspconfig')

nvim_lsp.eslint.setup{}

nvim_lsp.ts_ls.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  single_file_support = false
}

-- Disables vim warnings in main init.lua
nvim_lsp.lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "on_attach" }
            }
        }
    }
}

-- Not sure why this disables vim warnings in this specific file, but not my main init.lua
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "on_attach", "require" }
            }
        }
    }
})

nvim_lsp.pylsp.setup{}

nvim_lsp.tailwindcss.setup{}

nvim_lsp.clangd.setup{}

nvim_lsp.gopls.setup{}

-- Autocomplete configuration
local cmp = require("cmp")
cmp.setup({
    sources = {
        {name = "nvim_lsp"},
    },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),
})

-- Function to toggle diagnostics
function Toggle_diagnostics()
    if vim.g.diagnostics_active then
        vim.g.diagnostics_active = false
        vim.diagnostic.enable(false)
    else
        vim.g.diagnostics_active = true
        vim.diagnostic.enable()
    end
end
vim.keymap.set('n', '<leader>dt', Toggle_diagnostics, { noremap = true, silent = true, desc = "Toggle vim diagnostics" })
