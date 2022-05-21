execute 'autocmd! BufwritePost '.expand('<sfile>:p').' source %'

augroup CommonConfig
    autocmd!
augroup END


" Encoding {{{
set encoding=utf-8
set fileencodings=utf-8,cp950
" }}}


" General {{{
set hidden                   " Hide buffers when abandoned instead of unload
set fileformats=unix,dos,mac " Use Unix as the standard file type
set clipboard+=unnamedplus   " Specify to automatically use the system clipboard for copy and paste
set mouse=a

set endofline                " Write for the last line in the file
set foldmethod=syntax
set nofoldenable
set ignorecase
set smartcase                " Smart deciding search case
set splitbelow
set splitright
" }}}

" Show Relative Number {{{
set number
" set relativenumber number " Display current line number and relative number
" }}}

" Appearance {{{
" colorscheme onedark
" colorscheme papercolor
"  let g:vscode_style = "dark"
" colorscheme vscode
colorscheme catppuccin
set t_Co=256

syntax on

set laststatus=2        " Show status line
set wrap
" set colorcolumn=80      " Highlight the 80th character limit
set colorcolumn=
set scrolloff=5         " Keep at least 5 lines above/below
set showcmd             " Show command in status line
set cursorline          " Show cursorline
" }}}


" Tabs and Indents {{{
set cindent
set autoindent          " Use same indenting on new lines
set smartindent         " Smart autoindenting on new lines
" }}}

" Space {{{
set expandtab
set tabstop=4
set shiftwidth=4
" }}}

