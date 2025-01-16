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
" set background=light
set pastetoggle=<F2>
set ts=4 sts=4 sw=4
set expandtab
set completeopt-=preview

set complete=.,w,b,t
" The default is ".,w,b,u,t,i", which means to scan:
"    1. the current buffer
"    2. buffers in other windows
"    3. other loaded buffers
"    4. unloaded buffers
"    5. tags
"    6. included files

"=========================================

call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/tComment'
Plug 'bling/vim-bufferline'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
" Plug 'jiangmiao/auto-pairs'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'ziglang/zig.vim'
Plug 'valloric/youcompleteme'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'nordtheme/vim'
call plug#end()

"=========================================

let mapleader = "\<Space>"

let g:SuperTabCrMapping=1

let g:tagbar_ctags_bin = "/usr/bin/ctags-universal"

let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_sort = 0

let g:bufferline_show_bufnr = 0
let g:rustfmt_autosave = 1

let g:nord_bold_vertical_split_line = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1

" let g:go_highlight_structs = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1

let g:ycm_language_server =
    \ [
    \    {
    \     'name': 'zls',
    \     'filetypes': [ 'zig' ],
    \     'cmdline': [ '/home/denis/src/zls/zig-out/bin/zls' ]
    \    }
    \ ]

" let g:ycm_autoclose_preview_window_after_insertion = 1

"=========================================

inoremap kj <esc>

" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

map <Leader>n :bn<cr>
map <Leader>p :bp<cr>
map <Leader>d :bd<cr>

map <Leader>s :update<CR>
map <Leader>h :nohl<CR>
" map <Leader>q :q<CR>
" map <Leader>w :w<CR>
nmap <leader>i <plug>(YCMHover)

map <leader>o <C-o>

" map <Leader>g :YcmCompleter GoTo<CR>
map <Leader>j :YcmCompleter GoTo<CR>
" map <C-j> :YcmCompleter GoTo<CR>
" map <Leader>j :TagbarToggle<CR>
map <Leader>f :NERDTreeToggle<CR>
" map <Leader>o :!<CR>

"=========================================

autocmd BufWritePre * :%s/\s\+$//e

autocmd FileType c map <Leader>r :!clear;make run;<CR>

autocmd FileType zig map <Leader>r :!clear;zig build run;<CR>
autocmd FileType zig map <Leader>t :!clear;zig build test;<CR>

autocmd FileType rust map <Leader>r :!clear;cargo run<CR>
" autocmd FileType rust map <Leader>r :term cargo build<CR>
" autocmd FileType rust map <Leader>c :!clear;cargo check<CR>
" autocmd FileType rust map <Leader>t :!clear;cargo test<CR>
" autocmd FileType rust map <Leader>v :!clear;cargo clippy<CR>

" au filetype go inoremap <buffer> . .<C-x><C-o>


"=========================================

colorscheme nord
hi Pmenu ctermbg=green gui=bold
hi Visual term=reverse cterm=reverse guibg=Grey
hi CursorLine cterm=NONE ctermbg=green ctermfg=white
