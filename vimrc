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

" resize window to full width or go back to previous size
nnoremap <C-w>z :<c-u>call <SID>ToggleWindowZoom()<CR>

let g:vimtmpsessionfile = ".vimtmp.session.swp"

function! s:ToggleWindowZoom()
  if filereadable(g:vimtmpsessionfile)
    call s:RestoreTempSession()
  else 
    call s:MakeTempSession()
    execute "normal! \<C-W>_\<C-W>|"
  endif
endfunction

function! s:MakeTempSession()
  echom "mksession"
  execute "mksession! " .g:vimtmpsessionfile
endfunction

function! s:RestoreTempSession()
  echom "rmsession"
  execute "source " .g:vimtmpsessionfile 
  silent execute "!rm " .g:vimtmpsessionfile
endfunction
