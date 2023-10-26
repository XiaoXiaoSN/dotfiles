execute 'autocmd! BufwritePost '.expand('<sfile>:p').' source %'

augroup PluginConfig
    autocmd!
augroup END

" Language Server Protocol {{{
lua require('setup')
lua require('lsp')
autocmd BufEnter * lua require'completion'.on_attach()
" }}}

" Autocompletion {{{

" note that must keep noinsert in completeopt, the others is optional
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}

" Format {{{

" Auto-format files prior to saving them with nvim-lsp
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

autocmd BufWritePre *.c lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.cpp lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.cxx lua vim.lsp.buf.formatting_sync(nil, 1000)

autocmd BufWritePre *.java lua vim.lsp.buf.formatting_sync(nil, 1000)

autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)

autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 1000)

autocmd BufWritePre *.css lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.html lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.json lua vim.lsp.buf.formatting_sync(nil, 1000)

autocmd BufWritePre *.vim lua vim.lsp.buf.formatting_sync(nil, 1000)

augroup fmt
    autocmd!
    autocmd BufWritePre *.sh undojoin | Neoformat
    autocmd BufWritePre *.md undojoin | Neoformat

    autocmd BufWritePre *.xml undojoin | Neoformat
    autocmd BufWritePre *.yaml undojoin | Neoformat
    autocmd BufWritePre *.yml undojoin | Neoformat
augroup END

let g:neoformat_enabled_javascript = [ 'prettier' ]
let g:neoformat_enabled_dockerfile = [ 'cat' ]
let g:neoformat_enabled_rego = [ 'opa' ]
let g:neoformat_rego_opa = {
            \ 'exe': 'opa',
            \ 'args': ['fmt'],
            \ 'stdin': 1,
            \ }

" }}}

" fzf {{{
" To ensure that this plugin works well with Tim Pope's fugitive,
" use the following patterns array:
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" }}}

" fzf {{{
" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit'
            \ }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment']
            \ }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

" Keep Binding for fzf
nnoremap <leader>fl :Rg<CR>
" nnoremap <leader>fl :Lines<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
" }}}

" NERDTree {{{
let g:NERDTreeWinSize=32
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowHidden=1        " display hidden files
let NERDTreeAutoCenter=1
let NERDTreeMinimalUI=1           " hidden hint
let NERDTreeChDirMode=2           " setting current dir when move NERDTree dir

function! NERDTree_open()
    if !exists("s:std_in")
        if argc() == 0
            NERDTree
        elseif argc() == 1 && isdirectory(argv()[0])
            execute 'NERDTreeToggle' argv()[0]
            wincmd p
            enew
            execute 'cd '.argv()[0]
        endif
    endif
endfunction

autocmd PluginConfig VimEnter * call NERDTree_open()
autocmd PluginConfig BufEnter * silent! NERDTreeMirror

noremap <silent> <C-b> :NERDTreeToggle<CR>
noremap <silent> <M-b> :NERDTreeToggle<CR>
noremap <silent> <leader>nf :NERDTreeFind<CR>
noremap <silent> <leader>e :NERDTreeFind<CR>
" }}}

" Airline {{{
let g:airline_theme='onedark'
" let g:airline_theme='sublimemonokai'
let g:airline_powerline_fonts=1                        " enable powerline-fonts
let g:airline#extensions#tabline#enabled=1             " enable tabline
let g:airline#extensions#tabline#left_sep=' '          " set left separator
let g:airline#extensions#tabline#left_alt_sep='|'      " set left separator which are not editing
let g:airline#extensions#tabline#tab_nr_type = 1       " tab number
let g:airline#extensions#tabline#buffer_nr_show=1      " show buffer number
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'default'
" }}}

" indentLine {{{
let g:indentLine_char = '┆'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1
let g:indentLine_enabled = 1
" }}}

" C/C++ {{{
autocmd FileType c,cpp nnoremap <leader>c :wa<CR>:make <CR>

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
" }}}

" Rust {{{
let g:rustfmt_autosave = 0
" }}}

" LaTeX {{{
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_view_general_options = '-w'

let g:vimtex_compiler_latexmk = {
            \ 'backend' : 'nvim',
            \ 'background' : 1,
            \ 'build_dir' : 'target',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'options' : [
            \   '-xelatex',
            \   '-pdf',
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \ }

autocmd FileType tex nnoremap <leader>c :VimtexCompile<CR>
autocmd FileType tex nnoremap <leader>v :VimtexView<CR>
" }}}

" vim-closetag {{{
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
            \ 'typescript.tsx': 'jsxRegion,tsxRegion',
            \ 'javascript.jsx': 'jsxRegion',
            \ }

let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'
" }}}

" vim-json {{{
let g:vim_json_syntax_conceal = 0
" }}}"

" vim-visual-multi {{{
let g:VM_mouse_mappings = 1
" }}}

" tpope/vim-abolish {{{
command! Snake call feedkeys("crs")
command! Pascal call feedkeys("crm")
command! Camel call feedkeys("crc")
command! Upper call feedkeys("cru")
command! Kebab call feedkeys("cr-")
command! DotCase call feedkeys("cr.")
command! SpaceCase call feedkeys("cr<space>")
" }}}

