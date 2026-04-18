return {
    {
        'morhetz/gruvbox',
        lazy = false,
        priority = 1000,
        init = function()
            vim.o.background = 'dark'
            vim.g.gruvbox_italic = 1
        end,
        config = function()
            vim.cmd.colorscheme('gruvbox')
        end,
    },
}
