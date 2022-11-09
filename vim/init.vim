set rtp+=~/git/personal/dotfiles/vim

lua << EOF
require("globals")
EOF

" set runtimepath=~/.config/nvim/,$VIMRUNTIME
call plug#begin('~/.config/nvim/autoload/plugged')

Plug '/home/mt/git/personal/dotfiles/vim'
Plug 'marcelTau/number-representation.nvim'

Plug 'voldikss/vim-floaterm'
Plug 'ThePrimeagen/refactoring.nvim'
Plug 'vuciv/vim-bujo'
Plug 'stevearc/vim-arduino'

" UML
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

" Personal Plugins
Plug '/home/mt/git/personal/FirstLuaPlugin'
Plug '/home/mt/git/public/scratchpad.nvim'

Plug 'Civitasv/cmake-tools.nvim'
Plug 'mfussenegger/nvim-dap'

" Java
Plug 'mfussenegger/nvim-jdtls'

" Lua
Plug 'folke/lua-dev.nvim'

Plug 'alvarosevilla95/luatab.nvim'
Plug 'L3MON4D3/LuaSnip'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'
Plug 'togglebyte/togglerust'
Plug 'mattn/webapi-vim'

Plug 'vim-test/vim-test'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"Plug 'vimwiki/vimwiki'
Plug 'babaybus/DoxygenToolkit.vim'
Plug 'preservim/nerdcommenter'
Plug 'mg979/vim-visual-multi'

Plug 'tpope/vim-heroku'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

" COLOR
Plug 'morhetz/gruvbox'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug 'sainnhe/gruvbox-material'
"Plug 'joshdick/onedark.vim'
Plug 'briones-gabriel/darcula-solid.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'Mofiqul/vscode.nvim'


" GIT
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'
Plug 'lewis6991/gitsigns.nvim'

" Movement
Plug 'ThePrimeagen/harpoon'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'emilienlemaire/clang-tidy.nvim'

" LSP
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'kristijanhusak/vim-dadbod-completion'

Plug 'onsails/lspkind-nvim'
"Plug 'https://github.com/mphe/grayout.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'glepnir/lspsaga.nvim'
call plug#end()

                                " +++ BASICS +++ "

" set guicursor=     " the cursor thingy
syntax on
filetype plugin on

" -- set nocompatible

inoremap ö <esc>
tnoremap ö <C-\><C-n>

let mapleader = " "
let g:indentLine_char_list = ['|', '|', '|', '|']

let g:bujo#window_width = 40

set nonu
"set nu rnu
"set nu
set conceallevel=0
set laststatus=3

autocmd CompleteDone * if !pumvisible() | pclose | endif
set belloff+=ctrlg
"set signcolumn=number
set signcolumn=yes:1
"set signcolumn=no
set nofixendofline

set fillchars+=vert:│
"set list
"set listchars=trail:.

                                " +++ SETS +++ "

" testing
set termguicolors

set scrolloff=0
set autoindent
set smartindent
set autoread
set inccommand=split
set mouse=a
set hidden
set noerrorbells
set expandtab
set tabstop=4 softtabstop=4
set shiftwidth=4
set nowrap
set smartcase
set noswapfile
set nobackup
set incsearch
set clipboard=unnamedplus
set cmdheight=1
set nowritebackup
set updatetime=50
set shortmess+=c
set encoding=utf8
set splitright
"set foldmethod=manual
set timeoutlen=500
set nofoldenable    " disable folding

" Debugging
packadd termdebug
let g:termdebug_wide = 1
let g:TermDebugging = 0
au User TermdebugStartPre let g:TermDebugging = 1
au User TermdebugStopPost let g:TermDebugging = 0
                                " +++ BASIC REMAPS +++ "
" MOVEMENT
noremap J 5j
noremap K 5k
nnoremap J 5j
nnoremap K 5k
vnoremap J 5j
vnoremap K 5k
nnoremap <leader>H :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>L :wincmd l<CR>
nnoremap <C-d> :bd <CR>
vnoremap <leader>p "_dP

nnoremap <C-f> :tabp<CR>
nnoremap <C-h> :tabn<CR>

" RESIZE
nnoremap <silent> <Leader>+ :vertical resize +10<CR>
nnoremap <silent> <Leader>- :vertical resize -10<CR>

nnoremap + :ALEDetail<CR>
nnoremap <leader>hi :ClangdSwitchSourceHeader<CR>
nnoremap <leader>7 :let @/=""<CR>
nnoremap <leader>cc NERDCommenterComment<CR>
nnoremap <C-Space> <plug>NERDCommenterComment
vnoremap <C-Space> <plug>NERDCommenterComment
nnoremap <leader>b :!./build.sh<CR>
"nnoremap <leader>s :!./send.sh<CR>

"set background=dark
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_ui_contrast='high'
let g:gruvbox_material_palette='original'
let g:gruvbox_material_transparent_background=1


"highlight Normal guibg=#282c34 guifg=White ctermbg=Black ctermfg=White "!!!!!!!!!!!!!!!!!!!!
"colorscheme default
"highlight PmenuSel ctermbg=Black ctermfg=White guibg=Black guifg=White
"highlight Pmenu ctermbg=Black ctermfg=White guibg=Black guifg=White

"colorscheme tokyonight
colorscheme gruvbox-material
"highlight Normal guibg=#282c34 guifg=White ctermbg=Black ctermfg=White "!!!!!!!!!!!!!!!!!!!!
"highlight Normal guibg=#0d0f31 guifg=White
"colorscheme darcula
"colorscheme onedark
" hi default CursorWord cterm=underline gui=underline
"hi default CursorWord  guibg=Search


"" Enable this to highlight the current word
"hi link CursorWord Search

"highlight Normal guibg=#282c34 guifg=White ctermbg=Black ctermfg=White "!!!!!!!!!!!!!!!!!!!!

"highlight IncSearch    ctermbg=Grey   ctermfg=0
"highlight Search    ctermbg=Grey   ctermfg=0

"highlight Pmenu ctermbg=Black ctermfg=White guibg=Black guifg=White

"hi debugPc guifg=NONE ctermfg=NONE guibg=#cc241d ctermbg=160 gui=NONE cterm=NONE
"hi debugBreakpoint guifg=#cc241d ctermfg=160 guibg=NONE ctermbg=NONE gui=reverse cterm=reverse

"highlight Normal guibg=Black guifg=White ctermbg=Black ctermfg=White
" highlight debugPc

"highlight Normal ctermbg=Black
"highlight NonText ctermbg=Black
"lua << EOF
  "require('colorbuddy').colorscheme('gruvbuddy')
"EOF
highlight WinSeparator guibg=None
set termguicolors

let g:ale_sign_warning = 'W'
let g:ale_sign_info = 'I'
let g:ale_sign_error = 'E'
let g:ale_sign_column_always = 0
let g:ale_sign_highlight_linenrs = 1

highlight link ALEErrorSignLineNr Error
highlight link ALEWarningSignLineNr Error
highlight link ALEInfoSignLineNr Error
highlight link ALEStyleErrorSignLineNr Error
highlight link ALEStyleWarningSignLineNr Error

"highlight link NormalFloat Error
"highlight link Pmenu Error

" those are good
"hi Float guifg=#fabd2f ctermfg=214 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
"hi Pmenu guifg=#ebdbb2 ctermfg=223 guibg=#3c3836 ctermbg=237 gui=NONE cterm=NONE
"hi PmenuSel guifg=#282828 ctermfg=235 guibg=#458588 ctermbg=66 gui=NONE cterm=NONE
"hi PmenuSbar guifg=NONE ctermfg=NONE guibg=#665c54 ctermbg=59 gui=NONE cterm=NONE
"hi PmenuThumb guifg=NONE ctermfg=NONE guibg=#ebdbb2 ctermbg=223 gui=NONE cterm=NONE

let g:ale_set_highlights = 0
hi! link ALEError Error
hi! link ALEWarning CodeWarning
hi! link ALEInfo CodeInfo
hi! link ALEErrorSign ErrorSign
hi! link ALEWarningSign WarningSign
hi! link ALEInfoSign InfoSign

                                " +++ TERMINAL +++ "
au BufEnter * if &buftype == 'terminal' | endif
function! OpenTerminal()
  vert split term://zsh
  set nornu
endfunction
nnoremap <leader>#  :call OpenTerminal()<CR>

function! HerokuLogDcBot()
    Heroku logs --app marcel-discord-bot --tail
endfunction

function! HerokuLogDynaDev()
    Heroku logs --app dynafood-development --tail
endfunction

function! HerokuLogDynaDep()
    Heroku logs --app dynafood-deployment --tail
endfunction

function! HerokuLogDynaServer()
    Heroku logs --app dynafood-server --tail
endfunction

lua << EOF
require'nvim-treesitter.configs'.setup {
  playground = { enable = true },
  ensure_installed = "c rust cpp javascript bash cmake lua make python tsx",
  ignore_install = {},
  indent = {
      enable = true
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
    use_languagetree = true
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
EOF
                                " +++ FUZZY FINDER +++ "

lua << EOF
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
        prompt_position = "top",
        height = 0.95,
        preview = true,
    },
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = { '.cmake/', 'CMakeFiles/', './cmake-build-debug', '*/**/*.o', '.clangd/', '.ccls/', '.cache/', '.settings/' },
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    -- file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
}
EOF

nnoremap <leader>ff     :lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>
nnoremap <C-p>          :lua require('telescope.builtin').git_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>
nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>lw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>vrc <cmd>:lua require('dotfile_search').search_dotfiles()<cr>
nnoremap <leader>hs <cmd>lua require('telescope.builtin').lsp_references()<cr>
" nnoremap <leader>qf <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>qf <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>n :cnext<cr>
nnoremap <leader>p :cprev<cr>
nnoremap <leader>ht :lua require'telescope.builtin'.help_tags()<cr>

                                " +++ FUZZY FINDER +++ "

set completeopt+=menuone
set completeopt+=noinsert
set completeopt-=preview

lua << EOF

local system_name = "Linux"
local sumneko_root_path = '/home/mt/lua-language-server'
-- local sumneko_binary_path = sumneko_root_path.."/bin/Linux/lua-language-server"
local sumneko_binary_path = '/home/mt/lua-language-server/bin/lua-language-server'
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")


local function on_attach()
    -- why tf is should this be here
end
require("nvim-lsp-installer").setup {
    automatic_installation = true
}
require'lspconfig'.volar.setup{}
require'lspconfig'.diagnosticls.setup{}
require'lspconfig'.graphql.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.prosemd_lsp.setup{}
require'lspconfig'.arduino_language_server.setup{
    on_attach=on_attach,
    cmd = {
        "arduino-language-server",
        "-cli-config", "/home/mt/.arduino15/arduino-cli.yaml",
        "-clangd", "/usr/bin/clangd",
        "-cli", "/usr/bin/arduino-cli",
        "-fqbn", "arduino:avr:uno"
    }
}

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/path/to/workspace-root/' .. project_name

-- local config = {
--     cmd = {'/home/mt/bin/jdtls'},
--     root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
-- }
-- require('jdtls').start_or_attach(config)
-- require'lspconfig'.jdtls.setup{config}

-- local config = {
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   cmd = {
-- 
--     -- 💀
--     'java', -- or '/path/to/java17_or_newer/bin/java'
--             -- depends on if `java` is in your $PATH env variable and if it points to the right version.
-- 
--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-Xms1g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--     '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
-- 
--     -- 💀
--     -- '-jar', '/home/mt/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
--     '-jar', '/home/mt/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
--          -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--          -- Must point to the                                                     Change this to
--          -- eclipse.jdt.ls installation                                           the actual version
-- 
-- 
--     -- 💀
--     '-configuration', '/home/mt/config_linux',
--                     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--                     -- Must point to the                      Change to one of `linux`, `win` or `mac`
--                     -- eclipse.jdt.ls installation            Depending on your system.
-- 
-- 
--     -- 💀
--     -- See `data directory configuration` section in the README
--     '-data', workspace_dir,
--   },
-- 
--   root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
--   -- root_dir = require('jdtls.setup').find_root('.git'),
-- 
--   -- Here you can configure eclipse.jdt.ls specific settings
--   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--   -- for a list of options
--   settings = {
--     java = {
--     }
--   },
-- 
--   -- Language server `initializationOptions`
--   -- You need to extend the `bundles` with paths to jar files
--   -- if you want to use additional eclipse.jdt.ls plugins.
--   --
--   -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--   --
--   -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
--   init_options = {
--     bundles = {}
--   },
-- }
-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- require('jdtls').start_or_attach(config)
local luadev = require("neodev").setup({
    library = {vimruntime = true, types = true, plugins = true},
    lspconfig = {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"},
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';')
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'}
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                    }
                }
            }
        }
    }
})
require'lspconfig'.sumneko_lua.setup(luadev)

-- require'lspconfig'.sumneko_lua.setup {
--     cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"};
--     settings = {
--         Lua = {
--         runtime = {
--             -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--             version = 'LuaJIT',
--             -- Setup your lua path
--             path = runtime_path,
--         },
--         diagnostics = {
--             -- Get the language server to recognize the `vim` global
--             globals = {'vim'},
--         },
--         workspace = {
--             -- Make the server aware of Neovim runtime files
--             library = vim.api.nvim_get_runtime_file("", true),
--         },
--         -- Do not send telemetry data containing a randomized but unique identifier
--         telemetry = {
--             enable = false,
--         },
--         },
--     },
-- }
local util = require 'lspconfig/util'
require'lspconfig'.clangd.setup {
    on_attach=on_attach,
    cmd = {
        "clangd",
        "--background-index",
        "-j=5",
        "--clang-tidy",
        "--suggest-missing-includes",
        "--all-scopes-completion",
        "--header-insertion=iwyu",
        "--completion-style=bundled",
        "--cross-file-rename",
        -- "--completion-style=detailed", this gives errors
        "--header-insertion-decorators",
    },

    init_options = {
        clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
    },
    root_dir = vim.loop.cwd,
    fallbackFlags = {
        "-std=c++2a"
    },
}

-- require('clang-tidy').setup{
--   checks = {
--     '-*',
--     'bugprone-*',
--     'cppcoreguidelines-avoid-*',
--     'readability-identifier-naming',
--     'misc-assert-side-effect',
--     'readability-container-size-empty-*',
--     'modernize-*'
--   },
--   ignore_severity = {}
-- }

require'lspconfig'.tsserver.setup{
    on_attach=on_attach,
    -- filetypes = { ".git", "javascript", "typescript", "typescriptreact", "typescript.tsx" },
    -- root_dir = function() return vim.loop.cwd() end      -- run lsp for javascript in any directory
}

-- require'lspconfig'.hls.setup{
--     on_attach=on_attach,
--     cmd = {'haskell-language-server-wrapper',
--             '--lsp'
--     },
--     root_dir = function() return vim.loop.cwd() end      -- run lsp for javascript in any directory
-- }
require'lspconfig'.cmake.setup{ on_attach=on_attach }
require'lspconfig'.pyright.setup{ on_attach=on_attach }
require'lspconfig'.rust_analyzer.setup({
    on_attach=on_attach,
    root_dir = function() return vim.loop.cwd() end,      -- run lsp for javascript in any directory
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})
require'lspconfig'.bashls.setup{ on_attach=on_attach }
EOF

let g:ale_python_pylint_options = '--disable=W0603 --disable=C0111 --disable=C0114 --disable=C0103 --disable=C0116'
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>sh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>dn :lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>dp :lua vim.diagnostic.goto_prev()<CR>
nnoremap <leader>rn :Lspsaga rename<CR>

" GIT
nnoremap <leader>gvd :Gvdiffsplit<CR>

" FIX WHITESPACE
nnoremap <leader>fw :FixWhitespace<CR>

let g:multi_cursor_use_default_mapping=0

" Default mapping
" let g:multi_cursor_start_word_key      = '<C-m>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-m>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

let g:ale_cpp_clang_options =           '-std=c++2a -Wall'
let g:ale_cpp_clangd_options =          '-std=c++2a -Wall'
let g:ale_cpp_clangcheck_options =      '-std=c++2a'
let g:ale_cpp_clangtidy_options =       '-std=c++2a'
let g:ale_cpp_clangtidy_extra_options = '-std=c++2a'
let g:ale_cpp_cppcheck_options =        '--enable=all'
let g:ale_cpp_gcc_options =             '-std=c++2a -Wall'

" Doxygen
let g:DoxygenToolkit_authorName="Marcel Taubert"
let g:doxygen_enhanced_color = 1
nnoremap <leader>id :Dox<cr>

" Harpoon
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <C-j> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <C-k> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <C-l> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <C-t> :lua require("harpoon.term").gotoTerminal(1)<CR>

nnoremap <leader>o :source $MYVIMRC<CR>
nnoremap <leader>ö :TSHighlightCapturesUnderCursor<CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" AUTOPAIRS
"let g:AutoPairs = {  }

" RUST
autocmd FileType rust nnoremap <leader>b :Compile<CR>
autocmd FileType rust nnoremap <leader>t :RustTest<CR>
autocmd FileType rust nnoremap <leader>r :Cargo run<CR>
autocmd FileType rust nnoremap <leader>gt :RustTest!<CR>
autocmd FileType rust nnoremap <leader>f :RustFmt<CR>
autocmd FileType rust :RustDisableInlayHints
"let g:rustfmt_autosave = 1

autocmd FileType cpp nnoremap <leader>r :CMakeRun<CR>
autocmd FileType cpp nnoremap <leader>t :FloatermNew! cmake -B build && cmake --build build && ./build/acompiler_tests --gtest_color=yes <CR>

"let test#strategy = {
  "\ 'nearest': 'kitty',
  "\ 'file':    'kitty',
  "\ 'suite':   'kitty',
"\}

autocmd FileType lua nnoremap <leader>b :w<cr> :source %<cr>

autocmd FileType markdown nnoremap <leader>n <Plug>BujoChecknormal<cr>

lua<<EOF
require('rust-tools').setup({})
-- require'lsp_extensions'.inlay_hints{
--     highlight = "Comment",
--     prefix = " > ",
--     aligned = false,
--     only_current_line = false,
--     enabled = { "ChainingHint" }
-- }
-- disable inlay hints
--require('rust-tools.inlay_hints').disable_inlay_hints()

local lspkind = require('lspkind')
lspkind.init() -- @todo was init

local cmp = require('cmp')
cmp.setup {
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
}

EOF
" autocmd BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require('lsp_extensions').inlay_hints{ prefix = ' -> ', enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
"autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[2 q\033\\"
"autocmd VimLeave * silent !echo -ne "\033ktmux;\033\033]12;gray\007\033\\"

autocmd BufEnter silent :TSBufEnable highlight<cr>
nnoremap <leader>fl :VimwikiFollowLink<cr>
lua << EOF
require "luasnip-config"
EOF
nnoremap <leader>x :lua require('number-representation').get_representation()<CR>

nnoremap <leader><leader>x :luafile %<cr>

"let &t_SI = "\<Esc>[6 q"
"let &t_SR = "\<Esc>[4 q"
"let &t_EI = "\<Esc>[2 q"

"let &t_SI = "\<esc>[5 q"
"let &t_SR = "\<esc>[5 q"
"let &t_EI = "\<esc>[2 q"

au InsertEnter * silent execute "!print -n '\033[6 q'"
au InsertLeave * silent execute "!print -n '\033[1 q'"


lua << EOF
require("cmake-tools").setup {
  cmake_command = "cmake",
  cmake_build_directory = "build",
  cmake_build_type = "Debug",
  cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
  cmake_build_options = {},
  cmake_console_size = 10, -- cmake output window height
  cmake_show_console = "always", -- "always", "only_on_error"
  -- cmake_dap_configuration = { name = "cpp", type = "codelldb", request = "launch" }, -- dap configuration, optional
  -- cmake_dap_open_command = require("dap").repl.open, -- optional
}
EOF

lua << EOF
require('gitsigns').setup()
EOF
