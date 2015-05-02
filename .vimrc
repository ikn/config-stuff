" files
set nobackup
set nowritebackup
"" enables filetype detection
filetype plugin on
" search
set hlsearch
set incsearch
set ignorecase
set smartcase
" appearance
syntax on
set background=dark
set linebreak
set colorcolumn=80
set wrap
set linebreak
set list
set listchars=tab:▸\ ,trail:·
" editing: settings
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
" editing: keys
function! SmartHome()
  let s:col = col(".")
  normal! ^
  if s:col == col(".")
    normal! 0
  endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<CR>
inoremap <silent> <Home> <C-O>:call SmartHome()<CR>
nnoremap j gj
nnoremap <down> gj
nnoremap k gk
nnoremap <up> gk
nnoremap 0 g0
nnoremap $ g$
" shortcuts
"" d/ cancels search highlight
nnoremap <silent> d/ :noh<cr>
" fixes
"" no visual
map Q <Nop>
"" allow indenting #-prefixed lines with smartindent
inoremap # X#
