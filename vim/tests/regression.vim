" run with: vim -Nu vim/vimrc -i NONE -n -es -S vim/tests/regression.vim
let s:config = expand('<sfile>:p:h:h') . '/vimrc'
let s:tempdir = tempname()
call mkdir(s:tempdir, 'p')
let s:startup_error = v:errmsg
let s:path = $PATH

try
  call assert_equal('', s:startup_error, 'startup')
  execute 'source ' . fnameescape(s:config)
  execute 'source ' . fnameescape(s:config)
  set clipboard=

  call feedkeys(":W \<C-B>\"\<CR>", 'xt')
  call assert_equal('"w ', histget(':', -1), 'Ex command abbreviation')
  call feedkeys(":W! \<C-B>\"\<CR>", 'xt')
  call assert_equal('"w! ', histget(':', -1), 'forced Ex command abbreviation')

  " use a private register so the test never changes the desktop clipboard
  let s:copy = maparg(',c', 'x', 0, 1)
  execute 'xnoremap ,c ' . substitute(s:copy.rhs, '"+', '"q', '')
  call setline(1, ['alpha', 'beta', 'gamma'])
  call feedkeys("gg0vll,cj", 'xt')
  call assert_equal('alp', getreg(s:copy.rhs =~# '"+' ? 'q' : '0'), 'visual copy')
  call assert_equal(2, line('.'), 'copy must not consume the next motion')

  call setline(1, ['W', 'w'])
  call cursor(2, 1)
  call feedkeys("/W\<CR>", 'xt')
  call assert_equal('W', @/, 'search abbreviation')
  call assert_equal(1, line('.'), 'smartcase search')
  call feedkeys(":let g:vim_review_argument = 'W'\<CR>", 'xt')
  call assert_equal('W', g:vim_review_argument, 'command argument abbreviation')

  let s:left = win_getid()
  vsplit
  let s:right = win_getid()
  call feedkeys("\<C-h>", 'xt')
  call assert_equal(s:left, win_getid(), 'window left')
  call feedkeys("\<C-l>", 'xt')
  call assert_equal(s:right, win_getid(), 'window right')
  split
  let s:bottom = win_getid()
  call feedkeys("\<C-k>", 'xt')
  call assert_equal(s:right, win_getid(), 'window up')
  call feedkeys("\<C-j>", 'xt')
  call assert_equal(s:bottom, win_getid(), 'window down')
  only!

  let v:hlsearch = 1
  call feedkeys("\<Esc>", 'xt')
  call assert_equal(0, v:hlsearch, 'clear search highlighting')

  setfiletype sh
  call setline(1, ['echo one', 'echo two', 'echo three'])
  call feedkeys('gg,/', 'xt')
  call assert_match('^#\s*echo one$', getline(1), 'comment line')
  call feedkeys('gg,/', 'xt')
  call assert_equal('echo one', getline(1), 'uncomment line')
  call feedkeys('ggVj,/', 'xt')
  call assert_match('^#\s*echo one$', getline(1), 'comment selection start')
  call assert_match('^#\s*echo two$', getline(2), 'comment selection end')
  call assert_equal('echo three', getline(3), 'comment selection boundary')
  call feedkeys('ggVj,/', 'xt')
  call assert_equal(['echo one', 'echo two', 'echo three'], getline(1, '$'), 'uncomment selection')

  enew!
  execute 'file ' . fnameescape(s:tempdir . '/one.txt')
  let s:first = bufnr()
  enew!
  execute 'file ' . fnameescape(s:tempdir . '/two.txt')
  let s:second = bufnr()
  call feedkeys(',h', 'xt')
  call assert_equal(s:first, bufnr(), 'previous buffer')
  call feedkeys(',l', 'xt')
  call assert_equal(s:second, bufnr(), 'next buffer')
  call feedkeys(',j', 'xt')
  call assert_equal(s:first, bufnr(), 'previous buffer alias')
  call feedkeys(',k', 'xt')
  call assert_equal(s:second, bufnr(), 'next buffer alias')

  enew!
  execute 'file ' . fnameescape(s:tempdir . '/save.sh')
  setlocal noundofile
  let g:vim_review_pre = 0
  let g:vim_review_post = 0
  augroup VimReviewSave
    autocmd!
    autocmd BufWritePre <buffer> let g:vim_review_pre += 1
    autocmd BufWritePost <buffer> let g:vim_review_post += 1
  augroup END
  call setline(1, 'echo saved')
  doautocmd InsertLeave
  call assert_equal(['echo saved'], readfile(s:tempdir . '/save.sh'), 'autosave')
  call assert_equal([1, 1], [g:vim_review_pre, g:vim_review_post], 'nested save hooks and reload deduplication')
  doautocmd InsertLeave
  call assert_equal([1, 1], [g:vim_review_pre, g:vim_review_post], 'unchanged buffer')
  call setline(1, 'echo saved with shortcut')
  call feedkeys("\<C-s>", 'xt')
  call assert_equal(['echo saved with shortcut'], readfile(s:tempdir . '/save.sh'), 'save shortcut')
  call setline(1, 'echo saved')
  call feedkeys("\<M-s>", 'xt')
  call assert_equal(['echo saved'], readfile(s:tempdir . '/save.sh'), 'alternate save shortcut')
  setlocal readonly
  call setline(1, 'do not save')
  doautocmd InsertLeave
  call assert_equal(['echo saved'], readfile(s:tempdir . '/save.sh'), 'read-only buffer')
  setlocal noreadonly buftype=nofile
  doautocmd InsertLeave
  call assert_equal([3, 3], [g:vim_review_pre, g:vim_review_post], 'special buffer')
  setlocal buftype=

  call mkdir(s:tempdir . '/.git')
  call writefile([], s:tempdir . '/legitimate.txt')
  call writefile([], s:tempdir . '/.gitignore')
  call writefile([], s:tempdir . '/.gitfile')
  call writefile([], s:tempdir . '/.DS_Store')
  call assert_equal(1, g:NERDTreePath.New(s:tempdir . '/.DS_Store')._ignorePatternMatches('^\.DS_Store$'), 'macOS metadata file')
  let s:git_pattern = g:NERDTreeIgnore[-1]
  call assert_equal(1, g:NERDTreePath.New(s:tempdir . '/.git')._ignorePatternMatches(s:git_pattern), 'Git directory')
  for s:name in ['legitimate.txt', '.gitignore', '.gitfile']
    call assert_equal(0, g:NERDTreePath.New(s:tempdir . '/' . s:name)._ignorePatternMatches(s:git_pattern), s:name)
  endfor

  doautocmd VimEnter
  call assert_match('airline#statusline', &statusline, 'airline active')
  call assert_match('synIDattr', g:airline_section_x, 'airline syntax section')

  if executable('go') && executable('gofmt')
    " verify the fallback without starting a language server or using goimports
    let g:go_gopls_enabled = 0
    let g:go_code_completion_enabled = 0
    call mkdir(s:tempdir . '/bin')
    for s:tool in ['go', 'gofmt']
      call system('ln -s ' . shellescape(exepath(s:tool)) . ' ' . shellescape(s:tempdir . '/bin/' . s:tool))
    endfor
    let $PATH = s:tempdir . '/bin'
    execute 'source ' . fnameescape(s:config)
    call assert_equal(0, executable('goimports'), 'isolated Go tool path')
    call writefile(['package main', ''], s:tempdir . '/main.go')
    enew!
    execute 'edit ' . fnameescape(s:tempdir . '/main.go')
    setlocal noundofile
    call setline(1, ['package main', '', 'func main(){println("hi")}'])
    doautocmd InsertLeave
    call assert_equal(['package main', '', 'func main() { println("hi") }'], readfile(s:tempdir . '/main.go'), 'gofmt autosave fallback')
  endif
catch
  call add(v:errors, v:exception . ' at ' . v:throwpoint)
finally
  let $PATH = s:path
  call delete(s:tempdir, 'rf')
endtry

if !empty(v:errors)
  call writefile(v:errors, '/dev/stderr')
  cquit
endif
call writefile(['Vim configuration regression checks passed'], '/dev/stdout')
qa!
