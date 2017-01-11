let g:MakeHeaderColumnWidth = get(g:, 'MakeHeaderColumnWidth', &colorcolumn)

" Set commenting command to either :TComment or :Commentary
let s:CommentPluginCommand = 'TComment'
if !exists(':TComment') && exists(':Commentary')
  let s:CommentPluginCommand = 'Commentary'
endif

function! s:make_header(replacement_character, comment_character)
  put=''.getline('.')
  set virtualedit=all
  let headerColumnUnpadded = g:MakeHeaderColumnWidth - 2
  execute 'normal! 0' . headerColumnUnpadded . 'l'
  execute 'normal vT' . a:comment_character . 'l'
  execute 'normal r' . a:replacement_character
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

  elseif &filetype == 'vim'
    " Turn current line into a comment
    let line_is_comment = matchstr(getline('.'), '"')
    if empty(line_is_comment)
      execute s:CommentPluginCommand
    endif
    call s:make_header('-', '"')
  elseif &filetype == 'html' || &filetype == 'javascript' || &filetype == 'css' || &filetype == 'scss' || &filetype == 'php'
    " Turn current line into a comment
    let line_is_comment = matchstr(getline('.'), '//')
    if empty(line_is_comment)
      execute s:CommentPluginCommand
    endif
    call s:make_header('-', '/')

    " Restore the cursor line position after adding 2 lines
    let cursor_position[1] += 1
  endif

  " Restore virtualedit
  let &virtualedit = virtualedit

  " Restore the previous cursor position
  call setpos('.', cursor_position)

endfunction
