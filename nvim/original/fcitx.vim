execute 'autocmd! BufwritePost '.expand('<sfile>:p').' source %'

" Fcitx input method {{{
" reference: https://fcitx.github.io/handbook/chapter-remote.html
if has("unix")
    if executable('fcitx-remote')
        let g:fcitx_input_toggle = 0
        function! Fcitx2en()
            let s:input_status = system('fcitx-remote')
            if s:input_status == 2
                let g:fcitx_input_toggle = 1
                let l:a = system('fcitx-remote -c')
            endif
        endfunction

        function! Fcitx2zh()
            let s:input_status = system('fcitx-remote')
            if s:input_status != 2 && g:fcitx_input_toggle == 1
                let l:a = system('fcitx-remote -o')
                let g:fcitx_input_toggle = 0
            endif
        endfunction

        autocmd InsertLeave * call Fcitx2en()
        autocmd InsertEnter * call Fcitx2zh()
    endif
endif
" }}}
