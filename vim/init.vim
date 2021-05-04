call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'yggdroot/indentline'              " visualize indentations

""" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" file manager
Plug 'scrooloose/nerdtree'
Plug 'unkiwii/vim-nerdtree-sync'


Plug 'jremmen/vim-ripgrep'
Plug 'preservim/nerdcommenter'
Plug 'bfrg/vim-cpp-modern'

" COLOR
Plug 'overcache/NeoSolarized'
Plug 'lifepillar/vim-gruvbox8'
Plug 'bronson/vim-trailing-whitespace' " TODO maybe map :FixWhitespace
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'doums/darcula'

" GIT
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'


" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update


" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'


call plug#end()

                                " +++ BASICS +++ "
syntax on
filetype plugin on
inoremap ö <esc>
let mapleader = " "
tnoremap ö <C-\><C-n>
nnoremap <F1> :so $MYVIMRC <CR>
let g:indentLine_char_list = ['|', '|', '|', '|']
set nu rnu
"set statusline=%{FugitiveStatusline()}%<%f\ %h%m%r
"set statusline=%{FugitiveStatusline()}
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
set guifont=Mono
set splitright
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11


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
nnoremap <silent> <leader>m :res 10<CR>

" ERROR INFORMATION
nnoremap + :ALEDetail<CR>

" SEARCH
nnoremap <leader>7 :let @/=""<CR>

" NERDTREE
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>cc NERDCommenterComment<CR>


                                " +++ COLOR +++ "
" GRUVBOX
"let g:gruvbox_filetype_hi_groups = 1    " Set to 1 to include syntax highlighting definitions for several filetypes.
"let g:gruvbox_plugin_hi_groups = 1      " Set to 1 to include syntax highlighting definitions for a number of popular plugins
"let g:gruvbox_invert_selection = 1
"set background=dark
"colorscheme gruvbox8_hard

colorscheme darcula
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_removed = '▶'
"let g:gitgutter_sign_modified = ''
"let g:gitgutter_sign_removed = '-'
"hi! link GitGutterAdd GitAddStripe
"hi! link GitGutterChange GitChangeStripe
"hi! link GitGutterDelete GitDeleteStripe

" fk those shitty signs on the side
"let g:ale_sign_error = '⚠️'
"let g:ale_sign_warning = '💡'
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_set_highlights = 0

"hi! link ALEError Error
"hi! link ALEWarning CodeWarning
"hi! link ALEInfo CodeInfo
"hi! link ALEErrorSign ErrorSign
"hi! link ALEWarningSign WarningSign
"hi! link ALEInfoSign InfoSign



"let g:enable_bold_font = 1
"let g:enable_italic_font = 1
"let g:hybrid_transparent_background = 1
"if (has("nvim"))
  ""For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"endif
"set background=dark
"colorscheme hybrid_material

" SOLARIZED
"colorscheme solarized
"let g:solarized_termcolors=256
"set background=dark
"colorscheme NeoSolarized
"let g:neosolarized_vertSplitBgTrans = 1
"let g:neosolarized_contrast = "high"
"let g:neosolarized_termBoldAsBright = 0
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
let g:cpp_no_function_highlight = 1

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "python", "cpp" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
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
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = { './cmake-build-debug', '*/*.o' },
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
EOF

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>lw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>vrc <cmd>:lua require('dotfile_search').search_dotfiles()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>hs <cmd>lua require('telescope.builtin').lsp_references()<cr>


                                " +++ FUZZY FINDER +++ "

set completeopt+=menuone
set completeopt+=noinsert
set completeopt-=preview

let g:completion_matching_strategy_list = [ 'exact', 'substring', 'fuzzy' ]

lua << EOF
local on_attach = require'completion'.on_attach

require'lspconfig'.tsserver.setup{ 
    on_attach=on_attach 
}

require'lspconfig'.clangd.setup {
    on_attach = require'completion'.on_attach,
    root_dir = function() return vim.loop.cwd() end
}

require'lspconfig'.pyright.setup{ on_attach=on_attach }
require'lspconfig'.gopls.setup{ on_attach=on_attach }
require'lspconfig'.rust_analyzer.setup{ on_attach=on_attach }
require'lspconfig'.bashls.setup{ on_attach=on_attach }

require'lspconfig'.hls.setup{
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { "haskell", "lhaskell" },

    lspinfo = function (cfg)
          -- return "specific"
          if cfg.settings.languageServerHaskell.logFile or false then
            return "logfile: "..cfg.settings.languageServerHaskell.logFile
          end
          return ""
    end;
    settings = {
      languageServerHaskell = {
        formattingProvider = "ormolu"
      }
    },
}
EOF

nnoremap <leader>vn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>sh :lua vim.lsp.buf.hover()<CR>


" GIT
nnoremap <leader>gvd :Gvdiffsplit<CR>
