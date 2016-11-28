command! -nargs=? MakeHeader call MakeHeader#init(<f-args>)

nnoremap <silent> gmh :MakeHeader small<CR>
nnoremap <silent> gmH :MakeHeader large<CR>
