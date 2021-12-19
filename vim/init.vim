call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'yggdroot/indentline'              " visualize indentations



""" New stuff
Plug 'mhinz/vim-startify'


""" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" file manager
Plug 'scrooloose/nerdtree'
Plug 'unkiwii/vim-nerdtree-sync'

""" Markdown viewer
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'babaybus/DoxygenToolkit.vim'

Plug 'jremmen/vim-ripgrep'
Plug 'preservim/nerdcommenter'
Plug 'bfrg/vim-cpp-modern'
Plug 'jiangmiao/auto-pairs'
Plug 'wsdjeg/vim-todo'
Plug 'machakann/vim-highlightedyank'
Plug 'mg979/vim-visual-multi'
" Plug 'terryma/vim-multple-cursors'


" COLOR
"Plug 'lifepillar/vim-gruvbox8'
Plug 'bronson/vim-trailing-whitespace'
"Plug 'doums/darcula'
"Plug 'sainnhe/gruvbox-material'
"Plug 'Shatur/neovim-ayu'
"Plug 'projekt0n/github-nvim-theme'
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'
"Plug 'RishabhRD/gruvy'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'

" GIT
Plug 'tpope/vim-fugitive'


" Debugger
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'ilyachur/cmake4vim'
" LSP
Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'williamboman/nvim-lsp-installer'
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
Plug 'glepnir/lspsaga.nvim'
call plug#end()
                                " +++ BASICS +++ "
syntax on
filetype plugin on
"set guicursor=     " the cursor thing
inoremap ö <esc>
tnoremap ö <C-\><C-n>
let mapleader = " "
let g:indentLine_char_list = ['|', '|', '|', '|']
set nu rnu
set laststatus=2
autocmd CompleteDone * if !pumvisible() | pclose | endif
set belloff+=ctrlg
set signcolumn=no

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
"set colorcolumn=80
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

" SWITCH HPP-CPP
nnoremap <leader>hi :ClangdSwitchSourceHeader<CR>
" SEARCH
nnoremap <leader>7 :let @/=""<CR>

" NERDTREE
nnoremap <C-m> :NERDTreeToggle<CR>
nnoremap <leader>cc NERDCommenterComment<CR>

nnoremap <leader>b :!./build.sh<CR>
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
let g:gruvbox_material_transparent_background = 1
set background=dark
"colorscheme gruvbox-material
 "colorscheme gruvbox8_hard
"colorscheme gruvbox
"colorscheme gruvy
"colorscheme gruvbuddy
lua << EOF
require('colorbuddy').colorscheme('gruvbuddy')
EOF

"lua << EOF
"require('ayu').setup({
    "mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    "overrides = {}, -- A dictionary with a group names associated with a dictionary with parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
"})
"EOF
"colorscheme ayu-dark
let g:cmake_compile_commands = 1
"colorscheme github_dark
"colorscheme darcula

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_removed = '▶'
"let g:gitgutter_sign_modified = ''
"let g:gitgutter_sign_removed = '-'
"hi! link GitGutterAdd GitAddStripe
"hi! link GitGutterChange GitChangeStripe
"hi! link GitGutterDelete GitDeleteStripe
" fk those shitty signs on the side
"let g:ale_sign_error = '⚠️'
 "let g:ale_sign_error = 'E'
 let g:ale_sign_error = ''
"let g:ale_sign_warning = '💡'
 "let g:ale_sign_warning = 'x'
 let g:ale_sign_warning = ''
"let g:ale_sign_error = ''
"let g:ale_sign_warning = ''
"let g:ale_set_highlights = 0
let g:ale_sign_column_always = 0
let g:ale_sign_highlight_linenrs = 1

"let g:ale_sign_error = 'red'
"let g:ale_sign_warning= 'red'
"let g:ale_sign_info= 'red'
"let g:ale_sign_style_error= 'red'
"let g:ale_sign_style_warning= 'red'

highlight link ALEErrorSignLineNr Error
highlight link ALEWarningSignLineNr Error
highlight link ALEInfoSignLineNr Error
highlight link ALEStyleErrorSignLineNr Error
highlight link ALEStyleWarningSignLineNr Error



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
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true


let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.tabnine = v:true
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

local function on_attach()
    -- why tf is should this be here
end

require'lspconfig'.clangd.setup {
    --on_attach = require'completion'.on_attach,
    on_attach=on_attach,
    root_dir = vim.loop.cwd,
    --autostart = true,
    --cmd = {
    --    "clangd",
    --    "--background-index",
    --    "-std=c++2a",
    --},
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
require'lspconfig'.rust_analyzer.setup{ on_attach=on_attach }
require'lspconfig'.bashls.setup{ on_attach=on_attach }
EOF
let g:ale_python_pylint_options = '--disable=W0603 --disable=C0111 --disable=C0114 --disable=C0103 --disable=C0116'
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>sh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>dn :lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>dp :lua vim.diagnostic.goto_prev()<CR>
nnoremap <leader>do :lua vim.diagnostic.open_float()<CR>

nnoremap <silent> <leader>ft <cmd>lua require('lspsaga.floaterm').open_float_terminal('./build.sh && zsh')<CR>
nnoremap <silent> <leader>fl <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <silent> <leader>fl <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
tnoremap <silent> <leader>ft <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

"
"lua << EOF
"require'lspinstall'.setup()

"local servers = require'lspinstall'.installed_servers()
"for _, server in pairs(servers) do
  "require'lspconfig'[server].setup{ on_attach=on_attach }
"end

"local function setup_servers()
  "require'lspinstall'.setup()
  "local servers = require'lspinstall'.installed_servers()
  "for _, server in pairs(servers) do
    "require'lspconfig'[server].setup{ on_attach=on_attach }
  "end
"end

"setup_servers()

"-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
"require'lspinstall'.post_install_hook = function ()
  "setup_servers() -- reload installed servers
  "vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
"end
"EOF

function! s:JbzCppMan()
    let old_isk = &iskeyword
    setl iskeyword+=:
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
    execute 'Man ' . str
endfunction
command! JbzCppMan :call s:JbzCppMan()

au FileType cpp nnoremap <buffer>H :JbzCppMan<CR>

" GIT
nnoremap <leader>gvd :Gvdiffsplit<CR>

" Debugger

nnoremap <leader>dl :call vimspector#Launch()<cr>
nnoremap <leader>db :call vimspector#ToggleBreakpoint()<cr>
nnoremap <leader>dsb :call vimspector#ListBreakpoints()<cr>
nnoremap <leader>di :call vimspector#StepInto()<cr>
nnoremap <leader>do :call vimspector#StepOver()<cr>
nnoremap <leader>dr :call vimspector#Restart()<cr>
nnoremap <leader>dc :call vimspector#Continue()<cr>
nnoremap <leader>dR :VimspectorReset<cr>


" AUTOPAIRS
let g:AutoPairs = { '{':'}' }

" FIX WHITESPACE
nnoremap <leader>fw :FixWhitespace<CR>

" Maximizer
nnoremap <leader>max :MaximizerToggle<CR>
nnoremap <leader>rmax :MaximizerToggle!<CR>

nnoremap <leader>r :luafile %<CR>

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

let g:ale_cpp_clang_options =           '-std=c++2a -Wall'
let g:ale_cpp_clangd_options =          '-std=c++2a -Wall'
let g:ale_cpp_clangcheck_options =      '-std=c++2a'
let g:ale_cpp_clangtidy_options =       '-std=c++2a'
let g:ale_cpp_clangtidy_extra_options = '-std=c++2a'
let g:ale_cpp_cppcheck_options =        '--enable=all'
let g:ale_cpp_gcc_options =             '-std=c++2a -Wall'

" Doxygen
let g:DoxygenToolkit_authorName="Marcel Taubert"
nnoremap <leader>id :Dox<cr>

nnoremap <leader>sl :%!awk '{print; total+=$1}END{print total}'<cr>
