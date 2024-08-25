local cmp = require("cmp")
local lspkind = require('lspkind')

lspkind.init()

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    }),
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },
    sources = cmp.config.sources({
        { name = 'calc' },
        { name = 'luasnip' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'vim-dadbod-completion' },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
    }),
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = '[buf]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[api]',
                path = '[path]',
            }
        }
    },
    experimental = {
        native_menu = false,
    },
})