execute 'autocmd! BufwritePost '.expand('<sfile>:p').' source %'

" YAML {{{
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" }}}

" Just {{{
autocmd BufNewFile,BufRead Justfile,justfile setf make
" }}}

" Vue {{{
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
" }}}
