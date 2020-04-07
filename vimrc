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

packadd! matchit

" file navigation
autocmd FileType javascript,svelte,html,css setlocal suffixesadd+=.js,.json,.html,.js,.css

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
