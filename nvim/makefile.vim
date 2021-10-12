execute 'autocmd! BufwritePost '.expand('<sfile>:p').' source %'

" Makefile {{{
if has("unix")
    if executable('nproc')
        let &makeprg = 'make -j'.(system('nproc')+1)
    endif
endif
" }}}
