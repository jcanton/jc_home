" Overwrite the goddamn function
function! airline#extensions#bufferline#init(ext)
  if get(g:, 'airline#extensions#bufferline#overwrite_variables', 1)
    highlight bufferline_selected gui=bold cterm=bold
    highlight link bufferline_selected_inactive airline_c_inactive
    let g:bufferline_inactive_highlight = 'airline_c'
    "let g:bufferline_active_highlight = 'bufferline_selected'
    let g:bufferline_active_highlight = 'airline_c'
    let g:bufferline_active_buffer_left = '['
    let g:bufferline_active_buffer_right = ']'
    let g:bufferline_separator = g:airline_symbols.space
  endif

  if exists("+autochdir") && &autochdir == 1
    " if 'acd' is set, vim-airline uses the path section, so we need ot redefine this here as well
    call airline#parts#define_raw('path', '%{bufferline#refresh_status()}'.bufferline#get_status_string())
  else
    call airline#parts#define_raw('file', '%{bufferline#refresh_status()}'.bufferline#get_status_string())
  endif
endfunction
