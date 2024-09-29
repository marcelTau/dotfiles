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
    -- 'mfussenegger/nvim-dap',
    -- 'rcarriga/nvim-dap-ui',
    -- 'theHamsta/nvim-dap-virtual-text',
    -- 'nvim-neotest/nvim-nio',
    -- 'vlopes11/rrust.nvim',
    -- {
    --     'mrcjkb/rustaceanvim',
    --     version = '^5', -- Recommended
    --     lazy = false, -- This plugin is already lazy
    -- }
}
