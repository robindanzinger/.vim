let g:coc_disable_startup_warning = 1
set termguicolors
" Correct RGB escape codes for vim inside tmux
if !has('nvim') && $TERM ==# 'screen-256color'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set background=dark
let g:everforest_background = 'hard'
let g:everforest_enable_italic = 0
let g:everforest_better_performance = 1

colorscheme everforest

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
autocmd BufNewFile,BufRead *.svelte set filetype=html
autocmd BufNewFile,BufRead *.vue set filetype=vue
autocmd BufNewFile,BufRead *.ts set syntax=javascript
autocmd BufNewFile,BufRead *.json set filetype=jsonc
syntax sync fromstart

" GREP
" use ripgrep
if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

command! -nargs=+ -complete=file Grep
    \ execute 'silent grep! <args>' | redraw! | cwindow

" bind K to grep word under cursor
nnoremap <leader>K :Grep "\b<C-R><C-W>\b"<CR>

"some delay problems when hitting <ESC> in visual mode in terminal
set timeoutlen=1000
set ttimeoutlen=0

set viminfo='100,<50,s10,h

" fzf 
set rtp+=~/.fzf

" shorthand for find files
" TODO nnoremap <leader>e 


" langmap
set langmap=ü[,ä],Ü{,Ä}

" quicklist quick navigation
nnoremap <silent> +q :cnext<cr>
nnoremap <silent> üq :cprev<cr>
nnoremap ; ,
nnoremap , ;

set cmdheight=2
" from coc, default is 4000 which might lead to poor user experience
set updatetime=300

let mapleader = "ö"

packadd! matchit

" file navigation
autocmd FileType javascript,svelte,html,css,vue setlocal suffixesadd+=.js,.json,.html,.js,.css,.vue,.svelte,index.ts

" console.log
nnoremap <leader>cl ^iconsole.log(<esc>A)<esc>
inoremap <C-c><C-l> console.log()<esc>ci(
inoremap <C-c><C-l><C-d> console.log('DEBUG',  )<esc>hi
" async => () { 
inoremap <C-a><C-f> async () => {<cr>
" () => { }
inoremap <C-f> () => {<cr>})<esc>O

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
nnoremap <leader>T :tabprevious<CR>
tnoremap <leader>t <C-w>N:tabnext<CR>
tnoremap <leader>T <C-w>N:tabprevious<CR>

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

nnoremap <leader>f ?\^<cr>

" go to function definition
" nnoremap <leader>gf :<c-u>call <SID>SearchFunctionDefinition()<cr>

" function! s:SearchFunctionDefinition()
"   let @/='function '.expand('<cword>').' *('
" 
"   execute 'normal n'
" endfunction

"bash shebang
nnoremap <leader>she ggi#!/bin/bash<ESC>

"open svelte file in vertical
command -complete=file_in_path -nargs=1 Sve
      \ call s:EditSvelteComponent("<args>")

function! s:EditSvelteComponent(file)
  echo "Edit svelte component" . a:file
  exe 1 . "wincmd w"
  exe 'edit '.a:file
  exe 2 . "wincmd w"
  exe 'edit '.substitute(a:file, "\.svelte", "\.das.js", "")
  return 1
endfunction

"mocha test
nnoremap <leader>mnt :<c-u>call <SID>NormalTest()<cr>

"mocha only test
nnoremap <leader>mst :<c-u>call <SID>SkipTest()<cr>

"mocha only test
nnoremap <leader>mot :<c-u>call <SID>OnlyTest()<cr>

function! s:NormalTest()
  execute ':s/\.\(only\|skip\)(/(/'
endfunction

function! s:SkipTest()
  silent execute ':s/\(it\|describe\)(/\1.skip(/'
endfunction

function! s:OnlyTest()
  silent execute ':s/\(it\|describe\)(/\1.only(/'
endfunction

"coc snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
xmap <leader>x <Plug>(coc-convert-snippet)

"jump to next placeholder
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

imap <C-j> <Plug>(coc-snippets-expand-jump)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"  inoremap <silent><expr> <TAB>
"        \ pumvisible() ? coc#_select_confirm() :
"        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"        \ <SID>check_back_space() ? "\<TAB>" :
"        \ coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" let g:coc_snippet_next = '<tab>'

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> üg <Plug>(coc-diagnostic-prev)
nmap <silent> äg <Plug>(coc-diagnostic-next)

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nmap <leader>i :CocCommand editor.action.organizeImport<cr>
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

set path=.
set path+=/usr/include
set path+=src/**
set path+=test/**
set path+=tests/**
set path+=app/**

set wildignore=node_modules/**,.svelte-kit/**,*.sh,\.*,coverage/**,**/__snapshots__/**

nmap <leader>s :syntax sync fromstart<CR>

vnoremap <leader>gf :call <SID>OpenSelectedFile()<CR>
vnoremap <leader>gs :call <SID>SearchString()<cr>

function! s:OpenSelectedFile()
  let temp = @t
  norm! gv"ty:vs<CR>
  exec "vs"
  exec "normal! \<c-w>l"
  exec "find " .. @t
  let @t = temp
endfunction

function! s:SearchString() 
  let text = <SID>GetSelectedString()
  let directory = input("Path: ", "", "file_in_path")
  exec "vim " . text . " " . directory 
endfunction 

function! s:GetSelectedString() 
  let temp = @t
  norm! gv"ty<CR>
  let sel = @t
  let @t = temp
  return sel
endfunction

"Vista

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 0

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
