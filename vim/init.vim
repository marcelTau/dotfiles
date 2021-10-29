call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'yggdroot/indentline'              " visualize indentations

""" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" file manager
Plug 'scrooloose/nerdtree'
Plug 'unkiwii/vim-nerdtree-sync'

""" Markdown viewer
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'jremmen/vim-ripgrep'
Plug 'preservim/nerdcommenter'
Plug 'bfrg/vim-cpp-modern'
Plug 'jiangmiao/auto-pairs'
Plug 'szw/vim-maximizer'
Plug 'wsdjeg/vim-todo'
Plug 'machakann/vim-highlightedyank'
Plug 'mg979/vim-visual-multi'
" Plug 'terryma/vim-multple-cursors'


" COLOR
Plug 'lifepillar/vim-gruvbox8'
Plug 'bronson/vim-trailing-whitespace'
Plug 'doums/darcula'
Plug 'sainnhe/gruvbox-material'


" GIT
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'


" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'ilyachur/cmake4vim'
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'kabouzeid/nvim-lspinstall'

call plug#end()
                                " +++ BASICS +++ "
syntax on
filetype plugin on
" set guicursor=
inoremap ö <esc>
tnoremap ö <C-\><C-n>
let mapleader = " "
let g:indentLine_char_list = ['|', '|', '|', '|']
set nu rnu
set laststatus=2
autocmd CompleteDone * if !pumvisible() | pclose | endif
set belloff+=ctrlg

                                " +++ SETS +++ "
set scrolloff=7
set autoindent
set smartindent
set autoread
set conceallevel=0
set autoread
set inccommand=nosplit " make things auto write while doing a %s/ replacement
set cursorline
set mouse=a
set termguicolors
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu rnu
set nowrap
set smartcase
set noswapfile
set nobackup
set incsearch
set clipboard=unnamedplus
set cmdheight=2
set updatetime=50
set shortmess+=c
set encoding=utf8
set colorcolumn=80
" set guifont=Mono
set splitright
" set guifont=Droid\ Sans\ Fira\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
set guifont=Fira\ Code:h12


                                " +++ BASIC REMAPS +++ "
" MOVEMENT
noremap J 5j
noremap K 5k
vnoremap J 5j
vnoremap K 5k
nmap <C-h> :bp<enter>
nmap <C-l> :bn<enter>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" RESIZE
nmap <C-k> :res +5<CR>
nmap <C-j> :res -5<CR>
nnoremap <silent> <Leader>+ :vertical resize +10<CR>
nnoremap <silent> <Leader>- :vertical resize -10<CR>

" ERROR INFORMATION
nnoremap + :ALEDetail<CR>

" SEARCH
nnoremap <leader>7 :let @/=""<CR>

" NERDTREE
nnoremap <C-m> :NERDTreeToggle<CR>
nnoremap <leader>cc NERDCommenterComment<CR>

nnoremap <leader>b :!./mybuild.sh<CR>
nnoremap <leader>s :!./send.sh<CR>


                                " +++ COLOR +++ "
" GRUVBOX
"colorscheme gruvbox8_hard
"let g:gruvbox_invert_selection = 1
"let g:gruvbox_bold = 0
"let g:gruvbox_italics = 1
"let g:gruvbox_italicize_strings = 1
"let g:gruvbox_filetype_hi_groups = 1    " Set to 1 to include syntax highlighting definitions for several filetypes.
"let g:gruvbox_plugin_hi_groups = 1      " Set to 1 to include syntax highlighting definitions for a number of popular plugins

let g:gruvbox_material_cursor = 'green'
let g:gruvbox_material_enable_italic = 0
" let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 0
let g:gruvbox_material_diagnostic_text_highlight = 1
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_disable_italic_comment = 0
let g:gruvbox_material_palette = 'mix'
"let g:gruvbox_material_enable_bold = 0
"let g:gruvbox_material_visual = 'blue background'
"let g:gruvbox_material_menu_selection_background = 'green'
"let g:gruvbox_material_diagnostic_virtual_text = 'colored'
"let g:gruvbox_material_transparent_background = 1
set background=dark
colorscheme gruvbox-material
" colorscheme gruvbox8_hard

let g:cmake_compile_commands = 1
" colorscheme darcula

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_removed = '▶'
"let g:gitgutter_sign_modified = ''
"let g:gitgutter_sign_removed = '-'
"hi! link GitGutterAdd GitAddStripe
"hi! link GitGutterChange GitChangeStripe
"hi! link GitGutterDelete GitDeleteStripe

" fk those shitty signs on the side
let g:ale_sign_error = '⚠️'
let g:ale_sign_warning = '💡'
"let g:ale_sign_error = ''
"let g:ale_sign_warning = ''
"let g:ale_set_highlights = 0

"hi! link ALEError Error
"hi! link ALEWarning CodeWarning
"hi! link ALEInfo CodeInfo
"hi! link ALEErrorSign ErrorSign
"hi! link ALEWarningSign WarningSign
"hi! link ALEInfoSign InfoSign

"let g:gitgutter_override_sign_column_highlight = 0

" AIRLINE
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1            " show tabs or all buffers if only one tab open
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_alt_sep=''
let g:airline_section_y = ''
let g:airline_section_z = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''

                                " +++ TERMINAL +++ "

au BufEnter * if &buftype == 'terminal' | endif
function! OpenTerminal()
  vert split term://zsh
endfunction
nnoremap <leader>#  :call OpenTerminal()<CR>


                                " +++ HIGHLIGHTING +++ "
" C++
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1
let g:cpp_no_function_highlight = 0

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  ignore_install = { "python" },
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
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = { './cmake/', './cmake-build-debug', '*/*.o' },
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
EOF

lua << EOF
require('telescope').load_extension('media_files')
EOF

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>lw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>vrc <cmd>:lua require('dotfile_search').search_dotfiles()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>hs <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>qf <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>asdf <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <leader>tt <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>n :cnext<cr>
nnoremap <leader>p :cprev<cr>


                                " +++ FUZZY FINDER +++ "

set completeopt+=menuone
set completeopt+=noinsert
set completeopt-=preview

let g:completion_matching_strategy_list = [ 'exact', 'substring', 'fuzzy' ]

"require'lspconfig'.tsserver.setup{
    "on_attach = require'completion'.on_attach,
    "root_dir = vim.loop.cwd
"}

lua << EOF

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
-- local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
-- local sumneko_root_path = '/home/mtaubert/.local/share/nvim/lspinstall/lua/sumneko-lua/extension/server/bin/Linux/lua-language-server'
local sumneko_root_path = '/home/mtaubert/.local/share/nvim/lspinstall/lua/sumneko-lua/extension/server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
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


local on_attach = require'completion'.on_attach

require'lspconfig'.sumneko_lua.setup{ on_attach=on_attach }

require'lspconfig'.clangd.setup {
    on_attach = require'completion'.on_attach,
    root_dir = vim.loop.cwd
}

require'lspconfig'.gopls.setup{ on_attach=on_attach }
require'lspconfig'.tsserver.setup{
    on_attach=on_attach,
    filetypes = { ".git", "javascript", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = function() return vim.loop.cwd() end      -- run lsp for javascript in any directory
}

require'lspconfig'.cmake.setup{ on_attach=on_attach }
require'lspconfig'.pyright.setup{ on_attach=on_attach }
require'lspconfig'.rust_analyzer.setup{ on_attach=on_attach }
require'lspconfig'.bashls.setup{ on_attach=on_attach }
EOF

nnoremap <leader>vn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>sh :lua vim.lsp.buf.hover()<CR>

lua << EOF
require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{ on_attach=on_attach }
end

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{ on_attach=on_attach }
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
EOF

" GIT
nnoremap <leader>gvd :Gvdiffsplit<CR>

" AUTOPAIRS
let g:AutoPairs = { '{':'}' }

" FIX WHITESPACE
nnoremap <leader>fw :FixWhitespace<CR>

" Maximizer
nnoremap <leader>max :MaximizerToggle<CR>
nnoremap <leader>rmax :MaximizerToggle!<CR>

" todo
nnoremap <leader>todo :OpenTodo<CR>

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
