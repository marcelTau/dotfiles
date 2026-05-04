local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local lemon_shark_path = vim.fn.expand("~/fooo/lemon_shark")
local lemon_shark_root = vim.uv.fs_realpath(lemon_shark_path)
local lemon_shark_cargo = vim.fs.joinpath(lemon_shark_root or lemon_shark_path, "Cargo.toml")
local default_rust_root = util.root_pattern("Cargo.toml", "rust-project.json", ".git")

local function is_lemon_shark(root_dir)
  if not root_dir then
    return false
  end

  local resolved_root = vim.uv.fs_realpath(root_dir)

  if not resolved_root or not lemon_shark_root then
    return false
  end

  return resolved_root == lemon_shark_root
    or vim.startswith(resolved_root, lemon_shark_root .. "/")
end

local function rust_analyzer_root_dir(fname)
  local resolved_file = vim.uv.fs_realpath(fname)

  if resolved_file and lemon_shark_root and vim.startswith(resolved_file, lemon_shark_root .. "/") then
    return lemon_shark_root
  end

  return default_rust_root(fname)
end

vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, {})
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
vim.keymap.set('n', '<leader>sh', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, {})
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, {})

vim.diagnostic.config({
  virtual_text = true,
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

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

lspconfig.rust_analyzer.setup({
  root_dir = rust_analyzer_root_dir,
  on_new_config = function(new_config, root_dir)
    if not is_lemon_shark(root_dir) then
      return
    end

    new_config.settings = vim.tbl_deep_extend("force", new_config.settings or {}, {
      ["rust-analyzer"] = {
        linkedProjects = { lemon_shark_cargo },
        cargo = {
          target = "riscv64gc-unknown-none-elf",
          allTargets = false,
          buildScripts = {
            enable = true,
          },
        },
        check = {
          allTargets = false,
        },
        procMacro = {
          enable = true,
        },
      },
    })
  end,
})
