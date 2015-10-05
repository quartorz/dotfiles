" enable syntax highlighting
syntax enable


set fileencoding=utf-8
set encoding=utf-8
scriptencoding utf-8

" fix backspace behavior
set backspace=indent,eol,start

" add markdown filetype
au BufRead,BufNewFile *.md set filetype=markdown

set nocompatible

set number
set ruler
set cursorline
set laststatus=2
set showmatch
set list
set listchars=tab:\|\ ,trail:~
set tabstop=4
set shiftwidth=4
set noexpandtab
set softtabstop=0

set mouse=a
set ttymouse=xterm2

set noshowmode


inoremap <c-e> <END>
inoremap <c-a> <HOME>

" show full-width space
"augroup highlightIdeographicSpace
"	autocmd!
"	autocmd ColorScheme * highlight IgeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
"	autocmd VimEnter,WinEnter * match IgeographicSpace /@/
"augroup END

"
" Neobundle
"

" set a directory managed by bundle
set runtimepath+=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle manages neobundle
NeoBundleFetch 'Shougo/neobundle.vim'


" other additional plugins...

" NERDTree (file explorer)
NeoBundle 'scrooloose/nerdtree'
let NERDTreeDirArrows=0


" vim-clang
NeoBundle 'justmao945/vim-clang'
let g:clang_c_options='-std=c11'
let g:clang_cpp_options='-std=c++1z --pedantic-errors -I~/verify/cpp/include'
let g:clang_auto=0


" markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'


" caw
NeoBundle 'tyru/caw.vim'
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)


" vim-quickhl
NeoBundle 't9md/vim-quickhl'
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)


" show ideographic space
NeoBundle '0xBADDCAFE/vim-highlightIdeographicSpace'


" vimtex
NeoBundle 'lervag/vimtex'
let g:vimtex_latexmk_enabled=1
let g:vimtex_latexmk_options = '-pdfdvi'
let g:vimtex_latexmk_continuous = 1
let g:vimtex_latexmk_background = 1
let g:vimtex_view_method = 'general'
let g:vimtex_latexmk_callback = 0

let g:vimtex_view_general_viewer = '~/SumatraPDF.exe'
let g:vimtex_view_general_options = '-forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'


" vimproc
" NeoBundle 'Shougo/vimproc.vim'

" NeoBundle 'osyo-manga/vim-reunions'
" NeoBundle 'osyo-manga/vim-marching'

NeoBundle 'Shougo/neocomplcache'

NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}

" Rust completion
NeoBundle 'rust-lang/rust.vim'

"
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'

colorscheme torte

NeoBundle 'Shougo/unite-outline'
nmap \o :Unite outline<CR>
xmap \o :Unite outline<CR>


NeoBundle 'itchyny/lightline.vim'
NeoBundle 'itchyny/landscape.vim'


" powerline
" NeoBundle 'alpaca-tc/alpaca_powertabline'
" NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
" NeoBundle 'Lokaltog/powerline-fontpatcher'


NeoBundle 'tpope/vim-fugitive'


NeoBundle 'itchyny/lightline.vim'


call neobundle#end()


filetype plugin indent on

" check not-installed plugins
" optional
NeoBundleCheck


" tab width
set tabstop=4
set shiftwidth=4


function! s:cpp()
	setlocal path+=~/verify/cpp/include
	setlocal path+=~/verify/cpp/lilib20150518

	setlocal matchpairs+=<:>

	nnoremap <buffer><silent> <Space>ii :execute "?".&include<CR> :noh<CR> o
endfunction

augroup vimrc-cpp
	autocmd!
	autocmd FileType cpp call s:cpp()
augroup END


" lightline settings
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . "\ue0a2" : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? "\ue0a0 "._ : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

