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
set number relativenumber
autocmd BufNewFile,BufRead *.svelte set syntax=html
autocmd BufNewFile,BufRead *.vue set filetype=html
autocmd BufNewFile,BufRead *.ts set syntax=javascript
syntax sync fromstart

let mapleader = "ö"

packadd! matchit

" file navigation
autocmd FileType javascript,svelte,html,css,vue setlocal suffixesadd+=.js,.json,.html,.js,.css

" console.log
nnoremap <leader>cl ^iconsole.log(<esc>A)<esc>
inoremap <C-c><C-l> console.log()<esc>ci(

" navigating between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Hack, because netrw uses <C-l> for window refresh
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw nnoremap <buffer> <C-l> <C-w>l
augroup END

tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l

" navigating between tabs
nnoremap <leader>t :tabnext<CR>
tnoremap <leader>t <C-w>N:tabnext<CR>

"go to normal mode in terminal
tnoremap <leader>n <C-w>N 

" resize window to full width or go back to previous size
nnoremap <C-w>z :<c-u>call <SID>ToggleWindowZoom()<CR>
tnoremap <C-w>z :<c-u>call <SID>ToggleWindowZoom()<CR>

let g:windowzoom_on = 0
let g:window_last_height = 0
let g:window_last_width = 0 
function! s:ToggleWindowZoom()
  if g:windowzoom_on
    call s:RestoreWindowSizes()
    let g:windowzoom_on = 0
  else 
    call s:StoreWindowSizes()
    execute "normal! \<C-W>_\<C-W>|"
    let g:windowzoom_on = 1
  endif
endfunction

function! s:StoreWindowSizes()
  let winnr = winnr()
  let g:window_last_height = winheight(winnr)
  let g:window_last_width = winwidth(winnr)
  echom "store window sizes ".g:window_last_height." ".g:window_last_width
endfunction

function! s:RestoreWindowSizes()
  echom "restore window sizes ".g:window_last_height." ".g:window_last_width
  execute "resize ".g:window_last_height." <cr>"
  execute "vertical resize ".g:window_last_width." <cr>"

endfunction

" source my vim
nnoremap <leader>smv :source $MYVIMRC<cr>

" go to function definition
nnoremap <leader>gf :<c-u>call <SID>SearchFunctionDefinition()<cr>

function! s:SearchFunctionDefinition()
  let @/='function '.expand('<cword>').' \?('

  execute 'normal n'
endfunction
