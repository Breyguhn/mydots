" #::::::::::::::: NeoVim config ::::::::::::::::#

" #::::::::::::::: Keybindings/Settings ::::::::::::::::#

map <C-o> :NERDTreeToggle<CR>
map <C-g> :Goyo<CR>
map <C-l> :Limelight<CR>

set nu
set autoindent
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
syntax on

" #::::::::::::::: LimeLight Colour Config ::::::::::::::::#

let g:lightline = {'colorscheme': 'wombat',}

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" #::::::::::::::: Goyo Config ::::::::::::::::#

function! s:goyo_enter()
    set nu
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
              qa!
        else
              qa
        endif
    endif
endfunction

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" #::::::::::::::: vim-plug stuffs :::::::::::::::#

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'

call plug#end()
