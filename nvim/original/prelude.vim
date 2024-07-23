execute 'autocmd! BufWritePost '.expand('<sfile>:p').' source %'

" Set leader key
let mapleader=","

" Edit and source $MYVIMRC {{{
nnoremap <leader>ve :NERDTree $VIMPATH<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
" }}}

" Shortcut for switch encoding {{{
nnoremap <F12> :e ++enc=utf-8<CR>
" }}}"

" navigate through QuickFix errors using Ctrl-j and Ctrl-k {{{
map <C-j> :cn<CR>
map <C-k> :cp<CR>
" }}}

" Abbreviations {{{
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
" }}}

" this will reselect and re-yank any text that is pasted in visual mode.
xnoremap p pgvy

" Grep program {{{
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" neovim terminal {{{
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif
" }}}

" Quick buffer jumper {{{
nnoremap <Leader>j :bprevious<CR>
nnoremap <Leader>h :bprevious<CR>
nnoremap <Leader>k :bnext<CR>
nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>0 :blast<CR>
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" close buffer without closing the window
" https://superuser.com/a/370121
command Bd bprevious | split | bnext | bdelete
" }}}
