"=========================================
" .vimrc by orca84
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
set laststatus=2
set background=light
set pastetoggle=<F2>
set ts=4 sts=4 sw=4 expandtab

"=========================================

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/tComment'
Plugin 'bling/vim-bufferline'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'jiangmiao/auto-pairs'
Plugin 'rust-lang/rust.vim'
Plugin 'ziglang/zig.vim'
" Plugin 'fatih/vim-go'
Plugin 'arcticicestudio/nord-vim'
Plugin 'itchyny/lightline.vim'
call vundle#end()
syntax on
filetype plugin indent on

"=========================================

let mapleader = "\<Space>"

let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_sort = 0

let g:bufferline_show_bufnr = 0
let g:lightline = {'colorscheme': 'nord'}

let g:nord_bold_vertical_split_line = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1

let g:rustfmt_autosave = 1
" let g:zig_fmt_autosave = 0

" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_interfaces = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1

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

map <Leader>r :!clear;go run main.go < test<CR>

map <Leader>m :!clear;make && ./a.out<CR>
map <Leader>o :!<CR>

"=========================================

autocmd BufWritePre * :%s/\s\+$//e
au BufReadPost *.tera set syntax=html

autocmd FileType rust map <Leader>r :!clear;cargo run<CR>
autocmd FileType rust map <Leader>b :!clear;cargo build --release<CR>
autocmd FileType rust map <Leader>c :!clear;cargo check<CR>
autocmd FileType rust map <Leader>t :!clear;cargo test<CR>
autocmd FileType rust map <Leader>v :!clear;cargo clippy<CR>

" autocmd FileType go nmap <leader>r <Plug>(go-run)
" autocmd FileType go nmap <leader>t <Plug>(go-test)
" autocmd FileType go nmap <leader>b <Plug>(go-build)
" autocmd FileType go nmap <leader>l <Plug>(go-lint)
" autocmd FileType go nmap <leader>v <Plug>(go-vet)

"=========================================

colorscheme nord
hi Pmenu ctermbg=green gui=bold
hi Visual term=reverse cterm=reverse guibg=Grey
hi CursorLine cterm=NONE ctermbg=green ctermfg=white
