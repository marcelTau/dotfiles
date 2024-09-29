return {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "williamboman/mason-null-ls.nvim",
    "jose-elias-alvarez/null-ls.nvim", -- Null LS plugin

    {
        'prettier/vim-prettier',
        build = 'yarn install --frozen-lockfile --production',  -- Equivalent to 'do' in vim-plug
        branch = 'release/0.x',  -- Specify the branch
        lazy = false,  -- Load the plugin immediately
    },
}