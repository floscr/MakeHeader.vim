function! MakeHeader#init(type)

  " Get the current line
  let line = getline('.')
  " Save the current cursor position
  let cursor_position = getpos('.')

  " Duplicate the current line below
  put=''.line

  if &filetype == "markdown"
    " Replace all characters with =
    silent! normal Vr=k
  endif

  " Restore the previous cursor position
  call setpos('.', cursor_position)

endfunction
