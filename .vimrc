"=========================================
" .vimrc by denis k.
"=========================================

set nocompatible
set nonumber
set nowrap
set hidden
set hlsearch
set incsearch
set smartindent
set nobackup
set noswapfile
set shiftround
set scrolloff=0
set laststatus=2
set background=light
set pastetoggle=<F2>
set ts=4 sts=4 sw=4
set expandtab

"=========================================

call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/tComment'
Plug 'bling/vim-bufferline'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'rust-lang/rust.vim'
Plug 'ziglang/zig.vim'
Plug 'cespare/vim-toml'
Plug 'ron-rs/ron.vim'
call plug#end()

"=========================================

let mapleader = "\<Space>"

let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_sort = 0

let g:bufferline_show_bufnr = 0
let g:rustfmt_autosave = 1

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
map <Leader>q :q<CR>
map <Leader>w :w<CR>

map <Leader>j :TagbarToggle<CR>
map <Leader>f :NERDTreeToggle<CR>
map <Leader>o :!<CR>

"=========================================

autocmd BufWritePre * :%s/\s\+$//e
au BufReadPost *.tera set syntax=html

autocmd FileType zig map <Leader>r :!clear;zig build run<CR>
autocmd FileType zig map <Leader>t :!clear;zig build test<CR>

" autocmd FileType rust map <Leader>r :!clear;cargo run -- --dev<CR>
autocmd FileType rust map <Leader>r :!clear;SECRET=shuba cargo run<CR>
autocmd FileType rust map <Leader>b :!clear;cargo build<CR>
" autocmd FileType rust map <Leader>b :!clear;cargo build --no-default-features --features discovery<CR>
autocmd FileType rust map <Leader>c :!clear;cargo check<CR>
autocmd FileType rust map <Leader>t :!clear;cargo test<CR>
autocmd FileType rust map <Leader>v :!clear;cargo clippy<CR>

"=========================================

hi Pmenu ctermbg=green gui=bold
hi Visual term=reverse cterm=reverse guibg=Grey
hi CursorLine cterm=NONE ctermbg=green ctermfg=white
