" Show line numbers
set number

" Remaps
nnoremap J 5j
nnoremap K 5k
vnoremap J 5j
vnoremap K 5k
nnoremap <C-f> :tabp<CR>
nnoremap <C-h> :tabn<CR>

inoremap ö <esc>
tnoremap ö <C-\><C-n>

set mouse=a

colorscheme koehler

set tabstop=4
set shiftwidth=4
set expandtab

set noswapfile

set smartindent     " Smart auto-indentation for code
set autoindent      " Copy indent from current line when starting a new line

autocmd FileType rust setlocal formatoptions+=ro comments=:///,://!,://
autocmd FileType make setlocal noexpandtab
set guicursor=n-v-c:block,i:ver25,r:hor20

set colorcolumn=80

set ttymouse=sgr
" set term=xterm-256color
