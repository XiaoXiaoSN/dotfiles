execute 'autocmd! BufwritePost '.expand('<sfile>:p').' source %'

" xclip {{{
if executable("xclip")
    nmap <F7> :w !xclip<CR><CR>
    vmap <F7> "*y
    nmap <S-F7> :r!xclip -o<CR>
endif
" }}}
