return {
    'simrat39/rust-tools.nvim',
    'togglebyte/togglerust',
    {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        config = function()
            require('crates').setup()
        end,
    },
}