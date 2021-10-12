execute 'autocmd! BufwritePost '.expand('<sfile>:p').' source %'

let $VIMPATH = fnamemodify(resolve(expand('<sfile>:p')), ':h')

source $VIMPATH/prelude.vim
source $VIMPATH/fcitx.vim
source $VIMPATH/makefile.vim
source $VIMPATH/clipboard.vim
source $VIMPATH/plugins.vim
source $VIMPATH/common.vim
source $VIMPATH/filetypes.vim
source $VIMPATH/plugin-config.vim
source $VIMPATH/util-functions.vim
