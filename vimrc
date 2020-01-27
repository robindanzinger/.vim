colorscheme smyck
filetyp plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set encoding=utf-8
set fileencoding=utf-8
set smartindent
set expandtab 
syntax on
set backspace=2
set number
autocmd BufNewFile,BufRead *.svelte set syntax=html
autocmd BufNewFile,BufRead *.ts set syntax=javascript
syntax sync fromstart

" navigating between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l

" resize windows, Fullscreen
nnoremap <C-w>F <C-w>\|<C-w>_
" should be enhanced to get previous size, but for simplicity all windows same
" size
nnoremap <C-w>f <C-w>=
