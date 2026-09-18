local M = {
    -- easily install language servers from within neovim
    "williamboman/mason.nvim",

    -- bridge gaps between mason and lspconfig
    "williamboman/mason-lspconfig.nvim",

    -- collection of configs for language servers
    "neovim/nvim-lspconfig",

    -- collect data from language servers and give it to nvim-cmp
    "hrsh7th/cmp-nvim-lsp",

    -- for code completion
    "hrsh7th/nvim-cmp",
}

return { M }
