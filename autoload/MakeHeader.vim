let g:MakeHeaderColumnWidth = get(g:, 'MakeHeaderColumnWidth', &colorcolumn)

function! s:make_header()
  " Add comment
  put=''.getline('.')
  set virtualedit=all
  let headerColumnUnpadded = g:MakeHeaderColumnWidth - 2
  execute 'normal! 0' . headerColumnUnpadded . 'l'
  execute 'normal vT' . '"' . 'l'
  silent! normal r-
  let block_line = getline('.')
  silent! normal k
  put!=''.block_line
endfunction

function! MakeHeader#init(type)

  let cursor_position = getpos('.') " Save the current cursor position
  let virtualedit = &virtualedit      " Save virtualedit setting

  " Markdown
  " Duplicate the current line below and replace all characters with =
  " if &filetype == 'markdown'
  if &filetype == 'markdown'
    put=''.getline('.')
    silent! normal Vr=k

  " Vimscript
  elseif &filetype == 'vim'

    " Turn current line into a comment
    let line_is_comment = matchstr(getline('.'), '"')
    if empty(line_is_comment)
      execute 'TComment'
    endif

    call s:make_header()

    " Set the last cursor position plus 1 line
    " because 1 line was inserted above
    let cursor_position[1] += 1

  endif

  " Restore virtualedit
  let &virtualedit = virtualedit

  " Restore the previous cursor position
  call setpos('.', cursor_position)

endfunction
