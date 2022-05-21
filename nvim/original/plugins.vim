execute 'autocmd! BufwritePost '.expand('<sfile>:p').' source %'

if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" User Interface {{{
" Color scheme
Plug 'joshdick/onedark.vim'
" Plug 'nlknguyen/papercolor-theme'
" Plug 'Mofiqul/vscode.nvim'
" Plug 'XiaoXiaoSN/vim-sublime-monokai'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" Status
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'sharkdp/fd'

" View and search LSP symbols
Plug 'liuchengxu/vista.vim'

" Language Server Protocol {{{
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
" }}}

" Enhance build-in LSP UI
" Plug 'glepnir/lspsaga.nvim'

" GitHub Copilot is an AI pair programmer
Plug 'github/copilot.vim'

" NERDtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
" }}}

" EditorConfig {{{
Plug 'editorconfig/editorconfig-vim'
" }}}

" Quick edit {{{
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'

Plug 'tomtom/tcomment_vim'
" Plug 'tpope/vim-commentary'
" }}}

" Git {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
" }}}

" Auto-pairing {{{
Plug 'jiangmiao/auto-pairs'
" }}}

" Better whitespace {{{
Plug 'ntpeters/vim-better-whitespace'
" }}}

" Visual-Block for multi-select {{{
Plug 'mg979/vim-visual-multi'
" }}}

" Syntax {{{
" LLVM Assembly
Plug 'ararslan/llvm.vim'

" TOML
Plug 'cespare/vim-toml'

" fish
Plug 'dag/vim-fish'

" Jenkinsfile
Plug 'martinda/Jenkinsfile-vim-syntax'
" }}}

" TMux {{{
Plug 'tmux-plugins/vim-tmux'
" }}}

" Code formatter {{{
Plug 'sbdchd/neoformat'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
" }}}

" move your cursor fast {{{
Plug 'easymotion/vim-easymotion'
" }}}

" indentLine {{{
Plug 'Yggdroot/indentLine'
" }}}

" vim-easygrep {{{
Plug 'dkprice/vim-easygrep'
" }}}

" Language {{{

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" C/C++
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'jalcine/cmake.vim'

" Rust
Plug 'rust-lang/rust.vim', {'for': 'rust'}

" Nix expressions
Plug 'LnL7/vim-nix', {'for': 'nix'}

" JSON
Plug 'elzr/vim-json', {'for': 'json'}

" JavaScript
Plug 'pangloss/vim-javascript', {'for': 'javascript'}

" TypeScript
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}

" JSX
Plug 'mxw/vim-jsx', {'for': 'javascript.jsx'}

" TSX
Plug 'ianks/vim-tsx', {'for': 'typescript.tsx'}

" Kotlin
Plug 'udalov/kotlin-vim', {'for': 'kotlin'}

" Java
Plug 'uiiaoo/java-syntax.vim', {'for': 'java'}

" Auto close tag
Plug 'alvan/vim-closetag'

" HTML5
Plug 'othree/html5.vim', {'for': 'html'}

" Fast HTML
Plug 'mattn/emmet-vim', {'for': 'html'}

" EJS Hightlight
Plug 'briancollins/vim-jst'

" CSS
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'

" Vue.js
Plug 'posva/vim-vue'

" Solidity
Plug 'tomlion/vim-solidity', {'for': 'solidity'}

" HCL
Plug 'jvirtanen/vim-hcl'

" LaTeX
" Plug 'lervag/vimtex', {'for': 'tex'}
" }}}

call plug#end()
