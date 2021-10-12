execute 'autocmd! BufwritePost '.expand('<sfile>:p').' source %'

" Background Transparent {{{
command BgTransparent execute ":hi Normal guibg=NONE ctermbg=NONE"
" }}}
