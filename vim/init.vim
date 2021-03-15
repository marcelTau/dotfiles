source $HOME/.config/nvim/plug-config/coc.vim

filetype plugin on
inoremap ö <esc>
syntax on

set scrolloff=7

" uncomment the following line to get block caret while in insert mode
 " set guicursor=

set autoindent
set smartindent

set cursorline
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
set undodir=~/.vim/undodir
set undofile
set incsearch
set clipboard=unnamedplus
set cmdheight=2
set updatetime=50
set shortmess+=c
set encoding=utf8
set guifont=Mono

""" 80 column grey bar
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" open new split panes to right and below
set splitright
set splitbelow
tnoremap ö <C-\><C-n>

"open Terminal on Enter in NORMAL mode
au BufEnter * if &buftype == 'terminal' | endif
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
" nnoremap <c-m> :call OpenTerminal()<CR>

call plug#begin('~/.config/nvim/autoload/plugged')

"autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'yggdroot/indentline'              " visualize indentations
Plug 'tpope/vim-fugitive'               " git in vim
" Plug 'editorconfig/editorconfig-vim'    " auto-load .editorconfig files

""" status bar at the bottom
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" file manager
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'unkiwii/vim-nerdtree-sync'

Plug 'lifepillar/vim-gruvbox8'          " GRUUUUUUUVBOX

""" fuzzy finder 
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'

Plug 'ericcurtin/CurtineIncSw.vim'      " toggle between header/implementation files

Plug 'jremmen/vim-ripgrep'
Plug 'lyuts/vim-rtags'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'

" Plug 'ryanoasis/vim-devicons'
call plug#end()

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11

let g:gruvbox_invert_selection='1'
set background=dark
colorscheme gruvbox8_hard

" {{{ Airline tweaks
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_statusline_ontop = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1            " show tabs or all buffers if only one tab open
let g:airline#extensions#fzf#enabled = 1

" airline_tabfill xxx ctermfg=7 ctermbg=18

" saved looked good
" let g:airline_theme='base16_gruvbox_dark_hard'
" let g:airline_statusline_ontop = 0
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1            " show tabs or all buffers if only one tab open


" {{{ colorscheme 
let g:gruvbox_filetype_hi_groups = 1    " Set to 1 to include syntax highlighting definitions for several filetypes.
let g:gruvbox_plugin_hi_groups = 1      " Set to 1 to include syntax highlighting definitions for a number of popular plugins


" chars for the indetations
let g:indentLine_char_list = ['|', '|', '|', '|']



let mapleader = " "

""" switch between c/cpp and corresponding h/hpp file
nnoremap <leader>fo :call CurtineIncSw()<CR>













let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 20

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let NERDTreeIgnore = ['\.o$']
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

nnoremap <leader>7 :let @/=""<CR>

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>cc NERDCommenterComment<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
let NERDTreeIgnore = [ '\.o$', 'cmake_install.*', 'CMakeFiles', 'CMakeCache.*', 'build' ]
let g:nerdtree_sync_cursorline = 1


"faster movement
noremap J 5j
noremap K 5k
vnoremap J 5j
vnoremap K 5k

" buffer movement
nmap <C-h> :bp<enter>
nmap <C-l> :bn<enter>
nmap <C-k> :bd<enter>

"resize windows
nnoremap <silent> <Leader>+ :vertical resize +10<CR>
nnoremap <silent> <Leader>- :vertical resize -10<CR>
nnoremap <silent> <leader>m :res 10<CR>

"fzf
nnoremap <C-p> :Files<CR>

"move between windows 
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

"run makefile
" nnoremap <c-m> :!make re<CR>

" COC
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <silent> <leader>qf <Plug>(coc-fix-current)
nnoremap RC :CocRestart<CR><CR>

let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-vimlsp',
  \ 'coc-highlight',
  \ 'coc-fsharp',
  \ 'coc-json',
  \ 'coc-texlab'
  \ ]


" KITE 
set statusline=%<%f\ %h%m%r
" set statusline^=%{coc#status()}
set laststatus=2  " always display the status line
let g:kite_supported_languages = ['python', 'javascript', 'go']
" set completeopt+=menuone   " show the popup menu even when there is only 1 match
" set completeopt+=noinsert  " don't insert any text until user chooses a match
" set completeopt-=longest   " don't insert the longest common text
let g:kite_snippets=0
let g:kite_tab_complete=1
let g:kite_documentation_continual=0
" set completeopt+=preview


" autocmd CompleteDone * if !pumvisible() | pclose | endif
" autocmd BufNew,BufEnter *.py,*.c,*.cpp,*.hpp,*.h execute "silent! CocEnable"
