
call plug#begin('~/.config/nvim/autoload/plugged')

" Personal Plugins
Plug '/home/mtaubert/GIT/personal/FirstLuaPlugin'

Plug 'yggdroot/indentline'              " visualize indentations //@@@@

" Rust
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'christoomey/vim-sort-motion'
Plug 'vimwiki/vimwiki'
Plug 'babaybus/DoxygenToolkit.vim'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'wsdjeg/vim-todo'
Plug 'machakann/vim-highlightedyank'
Plug 'mg979/vim-visual-multi'
Plug 'SirVer/ultisnips'

" COLOR
Plug 'morhetz/gruvbox'
Plug 'rktjmp/lush.nvim'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'

" GIT
Plug 'tpope/vim-fugitive'

" Movement
Plug 'ThePrimeagen/harpoon'

" Telescope
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'

" cmake https://codevion.github.io/#!vim/cpp2.md
Plug 'cdelledonne/vim-cmake'
Plug 'alepez/vim-gtest'

" LSP
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'onsails/lspkind-nvim'

Plug 'mattn/vim-lsp-settings'
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'williamboman/nvim-lsp-installer'
"Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
Plug 'glepnir/lspsaga.nvim'
call plug#end()

                                " +++ BASICS +++ "

lua << EOF
P = function(v)
    print(vim.inspect(v))
    return v
end
EOF


"set guicursor=     " the cursor thing
syntax on
filetype plugin on
set nocompatible

inoremap ö <esc>
tnoremap ö <C-\><C-n>

let mapleader = " "
let g:indentLine_char_list = ['|', '|', '|', '|']
set nonu
"set nu
set conceallevel=0
set laststatus=2
autocmd CompleteDone * if !pumvisible() | pclose | endif
set belloff+=ctrlg
"set signcolumn=number
"set signcolumn=yes:1
set signcolumn=no
set nofixendofline

"set list
"set listchars=trail:.

                                " +++ SETS +++ "

" testing
"set termguicolors

set scrolloff=0
set autoindent
set smartindent
set autoread
set inccommand=nosplit " make things auto write while doing a %s/ replacement
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
nnoremap <leader>b :!./build.sh<CR>
nnoremap <leader>s :!./send.sh<CR>

"colorscheme gruvbox

"colorscheme default
lua << EOF
  require('colorbuddy').colorscheme('gruvbuddy')
EOF

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


lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = {},
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
      prompt_position = "bottom",
      horizontal = {
        width_padding = 0.04,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      },
    },
    preview = false,
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
  extensions = {
    project = {
      base_dirs = {
        {path = '~/GIT', max_depth = 3},
        
      }
    }
  },
}
require'telescope'.load_extension('project')
EOF

nnoremap <leader>ff     <cmd>Telescope find_files<cr>
nnoremap <C-p>          :lua require('telescope.builtin').git_files( require('telescope.themes').get_ivy( { preview = false }))<CR>
nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>lw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>vrc <cmd>:lua require('dotfile_search').search_dotfiles()<cr>
nnoremap <leader>hs <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>qf <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
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
local sumneko_binary_path = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")


local function on_attach()
    -- why tf is should this be here
end

--require'lspconfig'.sumneko_lua.setup {
--    cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"};
--    settings = {
--        Lua = {
--        runtime = {
--            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--            version = 'LuaJIT',
--            -- Setup your lua path
--            path = runtime_path,
--        },
--        diagnostics = {
--            -- Get the language server to recognize the `vim` global
--            globals = {'vim'},
--        },
--        workspace = {
--            -- Make the server aware of Neovim runtime files
--            library = vim.api.nvim_get_runtime_file("", true),
--        },
--        -- Do not send telemetry data containing a randomized but unique identifier
--        telemetry = {
--            enable = false,
--        },
--        },
--    },
--}

require'lspconfig'.clangd.setup {
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
    init_options = {
      clangdFileStatus = true,
    },
    root_dir = vim.loop.cwd,
    fallbackFlags = {
        "-std=c++2a"
    },
    on_attach=on_attach
}

require'lspconfig'.gopls.setup{ on_attach=on_attach }
require'lspconfig'.tsserver.setup{
    on_attach=on_attach,
    filetypes = { ".git", "javascript", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = function() return vim.loop.cwd() end      -- run lsp for javascript in any directory
}

require'lspconfig'.hls.setup{
    on_attach=on_attach,
    cmd = {'haskell-language-server-wrapper',
            '--lsp'
    },
    root_dir = function() return vim.loop.cwd() end      -- run lsp for javascript in any directory
}
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


"highlight hl-LspSignatureActiveParameter gui

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

let g:highlightedyank_highlight_duration = 300

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

let g:cmake_link_compile_commands = 1
let g:gtest#gtest_command="./build/tests/Test"
let g:gtest#print_time = 1
let g:cmake_default_config = "build"

" AUTOPAIRS
let g:AutoPairs = { '{':'}' }

" RUST
autocmd FileType rust nnoremap <leader>b :Cargo build<CR>
autocmd FileType rust nnoremap <leader>t :RustTest<CR>
autocmd FileType rust nnoremap <leader>r :Cargo run<CR>
autocmd FileType rust nnoremap <leader>gt :RustTest!<CR>
autocmd FileType rust nnoremap <leader>f :RustFmt<CR>
autocmd FileType rust let b:AutoPairs = { }
"let g:rustfmt_autosave = 1


autocmd FileType lua nnoremap <leader>b :w<cr> :source %<cr>


lua<<EOF
require('rust-tools').setup({})
require'lsp_extensions'.inlay_hints{
    highlight = "Comment",
    prefix = " > ",
    aligned = false,
    only_current_line = false,
    enabled = { "ChainingHint" }
}

local lspkind = require('lspkind')
lspkind.init()

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
    sources = cmp.config.sources({
        { name = "nvim_lua" }, -- max_item_count
        { name = "nvim_lsp" }, -- max_item_count
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
autocmd BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require('lsp_extensions').inlay_hints{ prefix = ' -> ', enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[2 q\033\\"
autocmd VimLeave * silent !echo -ne "\033ktmux;\033\033]12;gray\007\033\\"

nnoremap <leader>T :lua require'todoapp'.open('/home/mtaubert/GIT/personal/FirstLuaPlugin')<cr>
nnoremap <leader>fl :VimwikiFollowLink<cr>
