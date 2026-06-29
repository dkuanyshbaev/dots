" vim-plug bootstrap (run once on a fresh machine, then :PlugInstall):
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

set nocompatible
set nowrap
set hidden
set hlsearch
set incsearch
set autoindent
set nobackup
set noswapfile
set shiftround
set laststatus=2
set background=dark
set termguicolors
set ts=4 sts=4 sw=4
set expandtab

syntax on
filetype plugin indent on

set complete=.,w,b,t
" scan: current buffer (.), other windows (w), loaded buffers (b), tags (t)
" dropped vs default: u (unloaded buffers), i (included files) - noisy/slow for Rust

"=========================================

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'bling/vim-bufferline'
Plug 'ervandew/supertab'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'rust-lang/rust.vim'
Plug 'nordtheme/vim'
call plug#end()

"=========================================

let mapleader = "\<Space>"
let g:SuperTabCrMapping=1
let g:bufferline_show_bufnr = 0
let g:rustfmt_autosave = 1

let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_sort = 0

let g:nord_bold_vertical_split_line = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1

"=========================================

inoremap kj <esc>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <Leader>n :bn<cr>
map <Leader>p :bp<cr>
map <Leader>d :bd<cr>

map <Leader>s :update<CR>
map <Leader>h :nohl<CR>
map <Leader>j :TagbarToggle<CR>
map <Leader>f :NERDTreeToggle<CR>
map <Leader>o :!<CR>

"=========================================

function! s:StripTrailingWhitespace()
  let l:view = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:view)
endfunction
autocmd BufWritePre * if &filetype !=# 'rust' | call s:StripTrailingWhitespace() | endif

autocmd FileType rust map <Leader>r :!clear;cargo run<CR>
autocmd FileType rust map <Leader>b :!clear;cargo build<CR>
" autocmd FileType rust map <Leader>b :!clear;cargo build --release --features runtime-benchmarks<CR>
autocmd FileType rust map <Leader>c :!clear;cargo check<CR>
autocmd FileType rust map <Leader>t :!clear;cargo test<CR>
autocmd FileType rust map <Leader>v :!clear;cargo clippy<CR>

"=========================================

colorscheme nord
