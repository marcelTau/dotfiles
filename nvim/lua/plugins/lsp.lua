return {
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "rust_analyzer", "lua_ls", "pyright", "postgrestools"}
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    "neovim/nvim-lspconfig",
    {
        'stevearc/conform.nvim',
        opts = {},
    },
}
