
call plug#begin('~/.config/nvim/autoload/plugged')

" Personal Plugins
Plug '/home/mtaubert/GIT/personal/FirstLuaPlugin'
Plug '/home/mtaubert/GIT/public/scratchpad.nvim'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'
Plug 'togglebyte/togglerust'
Plug 'mattn/webapi-vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'vimwiki/vimwiki'
Plug 'babaybus/DoxygenToolkit.vim'
Plug 'preservim/nerdcommenter'
"Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi'

Plug 'tpope/vim-heroku'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-dadbod'

" COLOR
Plug 'morhetz/gruvbox'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'briones-gabriel/darcula-solid.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'doums/darcula'
" GIT
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'

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
Plug 'onsails/lspkind-nvim'
Plug 'https://github.com/mphe/grayout.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'glepnir/lspsaga.nvim'
call plug#end()

                                " +++ BASICS +++ "

lua << EOF
P = function(v)
    print(vim.inspect(v))
    return v
end
EOF


"set guicursor=     " the cursor thingy
syntax on
filetype plugin on

" -- set nocompatible

inoremap ö <esc>
tnoremap ö <C-\><C-n>

let mapleader = " "
let g:indentLine_char_list = ['|', '|', '|', '|']
"set nonu
"set rnu
set nu
set conceallevel=0
set laststatus=3

autocmd CompleteDone * if !pumvisible() | pclose | endif
set belloff+=ctrlg
"set signcolumn=number
"set signcolumn=yes:1
set signcolumn=no
set nofixendofline

set fillchars+=vert:│
"set list
"set listchars=trail:.

                                " +++ SETS +++ "

" testing
"set termguicolors

set scrolloff=0
set autoindent
set smartindent
set autoread
set inccommand=split
set mouse=a
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
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
set foldmethod=manual
set timeoutlen=500

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
nnoremap <leader>s :!./send.sh<CR>

"set background=dark
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_enable_italic = 1
"let g:gruvbox_material_ui_contrast='high'
let g:gruvbox_material_palette='original'
let g:gruvbox_material_transparent_background=0


"highlight IncSearch    ctermbg=Grey   ctermfg=0
"highlight Search    ctermbg=Grey   ctermfg=0

"colorscheme default

"highlight PmenuSel ctermbg=Black ctermfg=White guibg=Black guifg=White
"highlight Pmenu ctermbg=Black ctermfg=White guibg=Black guifg=White
"highlight Pmenu ctermbg=Black ctermfg=White guibg=Black guifg=White

"hi debugPc guifg=NONE ctermfg=NONE guibg=#cc241d ctermbg=160 gui=NONE cterm=NONE
"hi debugBreakpoint guifg=#cc241d ctermfg=160 guibg=NONE ctermbg=NONE gui=reverse cterm=reverse

"highlight Normal guibg=Black guifg=White ctermbg=Black ctermfg=White
"highlight Normal guibg=#282c34 guifg=White ctermbg=Black ctermfg=White "!!!!!!!!!!!!!!!!!!!!
" highlight debugPc

 "colorscheme gruvbox-material
"highlight Normal ctermbg=Black
"highlight NonText ctermbg=Black
lua << EOF
  require('colorbuddy').colorscheme('gruvbuddy')
EOF
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
local sumneko_root_path = '/home/mtaubert/.local/share/nvim/lspinstall/lua/sumneko-lua/extension/server'
local sumneko_binary_path = sumneko_root_path.."/bin/Linux/lua-language-server"
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")


local function on_attach()
    -- why tf is should this be here
end
require("nvim-lsp-installer").setup {
    automatic_installation = true
}
require'lspconfig'.jdtls.setup{}
require'lspconfig'.volar.setup{}
require'lspconfig'.asm_lsp.setup{}
require'lspconfig'.diagnosticls.setup{}
require'lspconfig'.graphql.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.prosemd_lsp.setup{}

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
            enable = false,
        },
        },
    },
}
local util = require 'lspconfig/util'
require'lspconfig'.vuels.setup {
    on_attach = function(client)
    --[[
    Internal Vetur formatting is not supported out of the box

    This line below is required if you:
    - want to format using Nvim's native `vim.lsp.buf.formatting**()`
    - want to use Vetur's formatting config instead, e.g, settings.vetur.format {...}
    --]]
    client.resolved_capabilities.document_formatting = true
    on_attach(client)
    end,
    capabilities = capabilities,
    settings = {
        vetur = {
            completion = {
                autoImport = true,
                useScaffoldSnippets = true
                },
            format = {
                defaultFormatter = {
                    html = "none",
                    js = "prettier",
                    ts = "prettier",
                    }
                },
            validation = {
                template = true,
                script = true,
                style = true,
                templateProps = true,
                interpolation = true
                },
            experimental = {
                templateInterpolationService = true
                }
            }
        },
        root_dir = util.root_pattern("header.php", "package.json", "style.css", 'webpack.config.js')
}

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

require'lspconfig'.gopls.setup{ on_attach=on_attach }
require'lspconfig'.tsserver.setup{
    on_attach=on_attach,
    filetypes = { ".git", "javascript", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = function() return vim.loop.cwd() end      -- run lsp for javascript in any directory
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


autocmd FileType lua nnoremap <leader>b :w<cr> :source %<cr>


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
require('rust-tools.inlay_hints').disable_inlay_hints()

local lspkind = require('lspkind')
lspkind.init() -- @todo was init

-- local cmp = require('cmp')
-- cmp.setup {
--     mapping = cmp.mapping.preset.insert({
--         ['<C-p>'] = cmp.mapping.select_prev_item(),
--         ['<C-n>'] = cmp.mapping.select_next_item(),
--         ['<C-j>'] = cmp.mapping.scroll_docs(4),
--         ['<C-k>'] = cmp.mapping.scroll_docs(-4),
--         ['<CR>'] = cmp.mapping.confirm({
--             behavior = cmp.ConfirmBehavior.Insert,
--             select = true,
--         }),
--     }),
--     sources = cmp.config.sources({
--         { name = "nvim_lua" }, -- max_item_count
--         { name = "nvim_lsp" }, -- max_item_count
--         { name = "path" },
--         { name = "buffer", keyword_length = 5 },
--     }),
--     formatting = {
--         format = lspkind.cmp_format {
--             with_text = true,
--             menu = {
--                 buffer = '[buf]',
--                 nvim_lsp = '[LSP]',
--                 nvim_lua = '[api]',
--                 path = '[path]',
--             }
--         }
--     },
--     experimental = {
--         native_menu = false,
--     },
-- }

EOF
" autocmd BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require('lsp_extensions').inlay_hints{ prefix = ' -> ', enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[2 q\033\\"
autocmd VimLeave * silent !echo -ne "\033ktmux;\033\033]12;gray\007\033\\"

autocmd BufEnter, ColroschemePre, BufWinEnter, BufAdd, BufReadCmd, BufReadPre * silent :TSBufEnable highlight
autocmd VimEnter :TSBufEnable highlight

"nnoremap <leader>T :lua require'todoapp'.open('/home/mtaubert/GIT/personal/FirstLuaPlugin')<cr>
nnoremap <leader>fl :VimwikiFollowLink<cr>
autocmd BufReadPost,BufWritePost * if &ft == 'c' || &ft == 'cpp' || &ft == 'hpp' || &ft == 'h'| exec 'GrayoutUpdate' | endif
let g:grayout_default_args = [ '-x', 'c++', '-std=c++11' ]
let g:grayout_libclang_path = '/home/mtaubert/.local/lib/python3.10/site-packages/clang/native/'

nnoremap <leader>d :lua require('scratchpad').toggle_buffer("cpp")<CR>
nnoremap <leader>f :lua package.loaded["scratchpad"] = nil<CR>
nnoremap <leader>g :lua require('scratchpad').run_code()<CR>
