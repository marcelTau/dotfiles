vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local function path_exists(path)
  return path and vim.uv.fs_stat(path) ~= nil
end

local function expand(path)
  return vim.fs.normalize(vim.fn.expand(path))
end

local function joinpath(...)
  return vim.fs.normalize(vim.fs.joinpath(...))
end

local home = vim.fs.normalize(vim.env.HOME)
local data_home = vim.fs.normalize(vim.env.XDG_DATA_HOME or joinpath(home, ".local", "share"))
local shared_nvim_data = joinpath(data_home, "nvim")
local shared_nvim_config = joinpath(home, ".config", "nvim")

local function github(repo)
  return ("https://github.com/%s.git"):format(repo)
end

local function shared_plugin_candidates(name)
  return {
    joinpath(shared_nvim_data, "plugged", name),
    joinpath(shared_nvim_config, "autoload", "plugged", name),
    joinpath(shared_nvim_data, "lazy", name),
  }
end

local function first_existing_path(candidates)
  for _, candidate in ipairs(candidates) do
    local resolved = expand(candidate)
    if path_exists(resolved) then
      return resolved
    end
  end
end

vim.pack.add({
  { name = "gitsigns.nvim", src = github("lewis6991/gitsigns.nvim") },
  { name = "mini.nvim", src = github("echasnovski/mini.nvim") },
  { name = "vim-fugitive", src = github("tpope/vim-fugitive") },
  { name = "committia.vim", src = github("rhysd/committia.vim") },
  { name = "rust.vim", src = github("rust-lang/rust.vim") },
  { name = "togglerust", src = github("togglebyte/togglerust") },
  { name = "nvim-lspconfig", src = github("neovim/nvim-lspconfig") },
}, {
  confirm = false,
  load = true,
})

local function add_runtimepath(candidates)
  local runtime_path = first_existing_path(candidates)
  if runtime_path then
    vim.opt.runtimepath:append(runtime_path)
    return runtime_path
  end
end

add_runtimepath({
  unpack(shared_plugin_candidates("nvim-treesitter")),
})

local treesitter_parsers = {}

local function add_treesitter_parser(lang)
  local parser_path = first_existing_path(vim.api.nvim_get_runtime_file(("parser/%s.so"):format(lang), false))
  if not parser_path then
    return false
  end

  local ok = vim.treesitter.language.add(lang, { path = parser_path })
  if ok then
    treesitter_parsers[lang] = true
  end

  return ok
end

add_treesitter_parser("rust")
add_treesitter_parser("sql")

vim.keymap.set("i", "ö", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "ö", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("t", "ö", "<C-\\><C-n>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>H", "<Cmd>wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<leader>j", "<Cmd>wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<leader>k", "<Cmd>wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<leader>L", "<Cmd>wincmd l<CR>", { silent = true })

vim.keymap.set({ "n", "v" }, "J", "5j", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "K", "5k", { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<leader>7", "<Cmd>nohl<CR>", { silent = true })

vim.keymap.set("n", "<C-f>", "<Cmd>tabp<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", "<Cmd>tabn<CR>", { silent = true })

vim.keymap.set({ "n", "v" }, "<leader>n", "<Cmd>cnext<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", "<Cmd>cprev<CR>", { silent = true })

vim.keymap.set("n", "<leader>+", "<Cmd>vertical resize +10<CR>", { silent = true })
vim.keymap.set("n", "<leader>-", "<Cmd>vertical resize -10<CR>", { silent = true })

vim.opt.number = true
vim.opt.conceallevel = 0
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 2
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.wildmode = "list:longest"
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.cmdheight = 0
vim.opt.inccommand = "split"
vim.opt.clipboard = "unnamedplus"
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.cmd.colorscheme("retrobox")

vim.keymap.set("i", "<C-Space>", function()
  vim.lsp.completion.get()
end, { silent = true })

vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 and vim.fn.complete_info({ "selected" }).selected ~= -1 then
    return "<C-y>"
  end
  return "<CR>"
end, { expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if vim.snippet.active({ direction = 1 }) then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  end
  return "<Tab>"
end, { expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if vim.snippet.active({ direction = -1 }) then
    return "<Cmd>lua vim.snippet.jump(-1)<CR>"
  end
  return "<S-Tab>"
end, { expr = true, silent = true })

vim.keymap.set("n", "<leader>qf", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>sh", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {})

local function format_with_prettier(bufnr)
  local filetype = vim.bo[bufnr].filetype
  if filetype ~= "javascript" and filetype ~= "typescript" and filetype ~= "typescriptreact" then
    return
  end

  if vim.fn.executable("prettier") == 0 then
    return
  end

  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename == "" then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local input = table.concat(lines, "\n")
  if vim.bo[bufnr].eol then
    input = input .. "\n"
  end

  local result = vim.system({
    "prettier",
    "--stdin-filepath",
    filename,
  }, {
    stdin = input,
    text = true,
  }):wait()

  if result.code ~= 0 or not result.stdout then
    return
  end

  local output_lines = vim.split(result.stdout, "\n", { plain = true })
  if output_lines[#output_lines] == "" then
    table.remove(output_lines, #output_lines)
  end

  local view = vim.fn.winsaveview()
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output_lines)
  vim.fn.winrestview(view)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.mjs", "*.cjs" },
  callback = function(args)
    format_with_prettier(args.buf)
  end,
})

local ok_gitsigns, gitsigns = pcall(require, "gitsigns")
if ok_gitsigns then
  gitsigns.setup()
end

local ok_mini_pick, mini_pick = pcall(require, "mini.pick")
local ok_mini_extra, mini_extra = pcall(require, "mini.extra")
if ok_mini_pick then
  local ui_select_orig = vim.ui.select
  mini_pick.setup()
  vim.ui.select = ui_select_orig

  local grep_picker_opts = {
    mappings = {
      send_all_to_quickfix = {
        char = "<C-q>",
        func = function()
          local matches = mini_pick.get_picker_matches()
          local items = matches and matches.all or {}
          if #items == 0 then
            vim.notify("No grep matches to send to quickfix", vim.log.levels.INFO)
            return false
          end

          mini_pick.default_choose_marked(items)
          return true
        end,
      },
    },
  }

  vim.keymap.set("n", "<leader>ff", mini_pick.builtin.files, { silent = true })
  vim.keymap.set("n", "<leader>lg", function()
    mini_pick.builtin.grep_live(nil, grep_picker_opts)
  end, { silent = true })
  vim.keymap.set("n", "<leader>lw", function()
    mini_pick.builtin.grep({ pattern = vim.fn.expand("<cword>") }, grep_picker_opts)
  end, { silent = true })
end

if ok_mini_pick and ok_mini_extra then
  mini_extra.setup()

  vim.keymap.set("n", "<leader>ds", function()
    mini_extra.pickers.lsp({ scope = "workspace_symbol_live" })
  end, { silent = true })

  vim.keymap.set("n", "<leader>hs", function()
    mini_extra.pickers.lsp({ scope = "references" })
  end, { silent = true })

  vim.keymap.set("n", "<C-p>", function()
    mini_extra.pickers.git_files()
  end, { silent = true })
end

vim.keymap.set("n", "<leader>gvd", "<Cmd>Gvdiffsplit<CR>", { silent = false })

require("git_tools").setup()

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "sql" },
  callback = function(event)
    local lang = event.match
    if treesitter_parsers[lang] and vim.treesitter.query.get(lang, "highlights") then
      pcall(vim.treesitter.start, event.buf, lang)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "typescriptreact", "tsx" },
  callback = function(event)
    vim.bo[event.buf].shiftwidth = 2
    vim.bo[event.buf].softtabstop = 2
    vim.bo[event.buf].expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set("n", "<leader>b", "<Cmd>Compile<CR>", opts)
    vim.keymap.set("n", "<leader>t", "<Cmd>RustTest<CR>", opts)
    vim.keymap.set("n", "<leader>r", "<Cmd>!cargo run<CR>", opts)
    vim.keymap.set("n", "<leader>gt", "<Cmd>RustTest!<CR>", opts)
    vim.keymap.set("n", "<leader>f", "<Cmd>RustFmt<CR>", opts)
    vim.g.rustfmt_autosave = 1
  end,
})

require("debug_rust")

if vim.fn.exists(":LspInfo") == 0 then
  vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("checkhealth vim.lsp")
  end, { desc = "Show Neovim LSP health information" })
end

local lsp_group = vim.api.nvim_create_augroup("Nvim012Lsp", { clear = true })

local function extend_completion_triggers(client)
  local completion_provider = client.server_capabilities.completionProvider
  if not completion_provider then
    return
  end

  local triggers = completion_provider.triggerCharacters or {}
  local seen = {}
  for _, char in ipairs(triggers) do
    seen[char] = true
  end

  for byte = string.byte("a"), string.byte("z") do
    local char = string.char(byte)
    if not seen[char] then
      table.insert(triggers, char)
      seen[char] = true
    end
  end

  for byte = string.byte("A"), string.byte("Z") do
    local char = string.char(byte)
    if not seen[char] then
      table.insert(triggers, char)
      seen[char] = true
    end
  end

  for byte = string.byte("0"), string.byte("9") do
    local char = string.char(byte)
    if not seen[char] then
      table.insert(triggers, char)
      seen[char] = true
    end
  end

  if not seen["_"] then
    table.insert(triggers, "_")
  end

  completion_provider.triggerCharacters = triggers
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    client.server_capabilities.semanticTokensProvider = nil

    if client:supports_method("textDocument/completion") then
      extend_completion_triggers(client)
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
      })
    end
  end,
})

local function executable_exists(binary)
  return vim.fn.executable(binary) == 1
end

local function register_rust_analyzer()
  local function reload_workspace(bufnr)
    local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })
    for _, client in ipairs(clients) do
      vim.notify("Reloading Cargo Workspace")
      client:request("rust-analyzer/reloadWorkspace", nil, function(err)
        if err then
          error(tostring(err))
        end
        vim.notify("Cargo workspace reloaded")
      end, 0)
    end
  end

  local function is_library(fname)
    local user_home = vim.fs.normalize(vim.env.HOME)
    local cargo_home = os.getenv("CARGO_HOME") or (user_home .. "/.cargo")
    local registry = cargo_home .. "/registry/src"
    local git_registry = cargo_home .. "/git/checkouts"
    local rustup_home = os.getenv("RUSTUP_HOME") or (user_home .. "/.rustup")
    local toolchains = rustup_home .. "/toolchains"

    for _, item in ipairs({ toolchains, registry, git_registry }) do
      if vim.fs.relpath(item, fname) then
        local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
        return #clients > 0 and clients[#clients].config.root_dir or nil
      end
    end
  end

  vim.lsp.config("rust_analyzer", {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local reused_dir = is_library(fname)
      if reused_dir then
        on_dir(reused_dir)
        return
      end

      local cargo_crate_dir = vim.fs.root(fname, { "Cargo.toml" })
      if cargo_crate_dir == nil then
        on_dir(
          vim.fs.root(fname, { "rust-project.json" })
            or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
        )
        return
      end

      vim.system({
        "cargo",
        "metadata",
        "--no-deps",
        "--format-version",
        "1",
        "--manifest-path",
        cargo_crate_dir .. "/Cargo.toml",
      }, { text = true }, function(output)
        if output.code == 0 and output.stdout then
          local ok, result = pcall(vim.json.decode, output.stdout)
          if ok and type(result) == "table" then
            local workspace_root = result.workspace_root and vim.fs.normalize(result.workspace_root) or cargo_crate_dir
            on_dir(workspace_root)
            return
          end

          vim.schedule(function()
            vim.notify("[rust_analyzer] failed to decode cargo metadata output", vim.log.levels.WARN)
          end)
        else
          vim.schedule(function()
            vim.notify("[rust_analyzer] cargo metadata failed: " .. (output.stderr or ""), vim.log.levels.WARN)
          end)
        end

        on_dir(cargo_crate_dir)
      end)
    end,
    settings = {
      ["rust-analyzer"] = {
        lens = {
          debug = { enable = true },
          enable = true,
          implementations = { enable = true },
          references = {
            adt = { enable = true },
            enumVariant = { enable = true },
            method = { enable = true },
            trait = { enable = true },
          },
          run = { enable = true },
          updateTest = { enable = true },
        },
      },
    },
    before_init = function(init_params, config)
      if config.settings and config.settings["rust-analyzer"] then
        init_params.initializationOptions = config.settings["rust-analyzer"]
      end
    end,
    on_attach = function(_, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, "LspCargoReload", function()
        reload_workspace(bufnr)
      end, { desc = "Reload current cargo workspace" })
    end,
  })
end

local function register_pyright()
  local function set_python_path(command)
    local path = command.args
    local clients = vim.lsp.get_clients({
      bufnr = vim.api.nvim_get_current_buf(),
      name = "pyright",
    })
    for _, client in ipairs(clients) do
      if client.settings then
        client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
      else
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
      end
      client:notify("workspace/didChangeConfiguration", { settings = nil })
    end
  end

  vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
      "pyrightconfig.json",
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      ".git",
    },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
        client.request("workspace/executeCommand", {
          command = "pyright.organizeimports",
          arguments = { vim.uri_from_bufnr(bufnr) },
        }, nil, bufnr)
      end, {
        desc = "Organize Imports",
      })
      vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
        desc = "Reconfigure pyright with the provided python path",
        nargs = 1,
        complete = "file",
      })
    end,
  })
end

local function register_postgres_lsp()
  vim.lsp.config("postgres_lsp", {
    cmd = { "postgres-language-server", "lsp-proxy" },
    filetypes = { "sql" },
    root_markers = { "postgres-language-server.jsonc" },
    workspace_required = true,
  })
end

local function register_ts_ls()
  vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    root_markers = {
      "tsconfig.json",
      "jsconfig.json",
      "package.json",
      ".git",
    },
  })
end

register_rust_analyzer()
vim.lsp.config("lua_ls", {
  on_init = function(client)
    if client.workspace_folders and client.workspace_folders[1] then
      local workspace = client.workspace_folders[1].name
      if workspace ~= vim.fn.stdpath("config") and (path_exists(workspace .. "/.luarc.json") or path_exists(workspace .. "/.luarc.jsonc")) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
      runtime = {
        version = "LuaJIT",
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    })
  end,
  settings = {
    Lua = {},
  },
})
register_pyright()
register_postgres_lsp()
register_ts_ls()

for _, server in ipairs({
  { name = "rust_analyzer", cmd = "rust-analyzer" },
  { name = "lua_ls", cmd = "lua-language-server" },
  { name = "pyright", cmd = "pyright-langserver" },
  { name = "postgres_lsp", cmd = "postgres-language-server" },
  { name = "ts_ls", cmd = "typescript-language-server" },
}) do
  if executable_exists(server.cmd) then
    vim.lsp.enable(server.name)
  end
end
