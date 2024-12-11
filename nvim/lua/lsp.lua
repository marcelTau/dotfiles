local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
-- Initialize Mason
mason.setup({
    -- ensure_installed = { "prettier" }
})

mason_lspconfig.setup({
    ensure_installed = { "rust_analyzer", "lua_ls", "pyright", "typescript_language_server"},
})

vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, {})
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
vim.keymap.set('n', '<leader>sh', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, {})
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, {})

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({})
    end,
    
    -- Example of custom setup for rust_analyzer
    ["rust_analyzer"] = function()
        lspconfig.rust_analyzer.setup({
            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                    },
                    assist = {
                        importGranularity = "module",
                        importPrefix = "by_self",
                    },
                    procMacro = {
                        enable = true
                    },
                },
            },
        })
    end,
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({})
    end,
    -- ["ts_ls"] = function()
    --     lspconfig.ts_ls.setup({
    --         on_attach = function() end,
    --         filetypes = { ".git", "javascript", "typescript", "typescriptreact", "typescript.tsx" },
    --     })
    -- end,
    ["solidity_ls"] = function()
        lspconfig.solidity_ls.setup({})
    end
})


require("conform").setup({
    formatters_by_ft = {
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
    },
})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require("conform").format({ bufnr = args.buf })
    end,
})