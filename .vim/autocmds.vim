"
" et: expandtab
" ic: ignorecase
" tw: textwidth

"------------------------------------------------------------------------------
" FILETYPES
"------------------------------------------------------------------------------

augroup Coc
au!
autocmd BufRead,BufNewFile
            \ *.cpp,*.h,*.hpp,*.c,*.usr,SIZE,USERPAR,CHKPOINT,*.py,*.tex,*.f,*.f90,*.vim
            \ call coc#config("suggest.autoTrigger", "always") " Always show CoC
augroup END

augroup Cpp
au!
autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp setlocal tw=80 cin noic autowrite
autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp setlocal expandtab shiftwidth=4 tabstop=4
" Enable clang-format by default on write
autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp ClangFormatAutoEnable
augroup END

augroup Fortran
au!
autocmd BufRead,BufNewFile *.f,*.f90 setlocal tw=80 noic autowrite
autocmd BufRead,BufNewFile *.f,*.f90 setlocal expandtab shiftwidth=2 tabstop=2
augroup END

augroup Nek
au!
autocmd BufRead,BufNewFile *.usr    setlocal expandtab shiftwidth=3 tabstop=3 filetype=fortran
autocmd BufRead,BufNewFile *.upar   setlocal expandtab shiftwidth=3 tabstop=3 filetype=fortran
autocmd BufRead,BufNewFile SIZE     setlocal expandtab shiftwidth=3 tabstop=3 filetype=fortran
autocmd BufRead,BufNewFile USERPAR  setlocal expandtab shiftwidth=3 tabstop=3 filetype=fortran
autocmd BufRead,BufNewFile CHKPOINT setlocal expandtab shiftwidth=3 tabstop=3 filetype=fortran
augroup END

augroup pyton
au!
autocmd BufRead,BufNewFile *.py setlocal tw=0 noic autowrite
autocmd BufRead,BufNewFile *.py setlocal expandtab shiftwidth=4 tabstop=4
autocmd BufRead,BufNewFile *.py setlocal foldmethod=indent foldlevel=99
augroup END

augroup tex
au!
autocmd BufRead,BufNewFile *.tex setlocal noic autowrite cc=81 "spell
autocmd BufRead,BufNewFile *.tex call pencil#init()
autocmd BufRead,BufNewFile *.tex setlocal conceallevel=0
autocmd BufRead,BufNewFile *.tex nmap <C-i> <Plug>IMAP_JumpForward
autocmd BufRead,BufNewFile *.tex map <F2> <ESC>:w<CR><leader>ll
autocmd BufRead,BufNewFile *.tex map <F3> <ESC>:w<CR><leader>lv
augroup END

function CheckKate()
    if filereadable("." . expand('%:t') . ".kate-swp")
    "if filereadable(expand('%:p'))
        echoerr "." . expand('%:t') . ".kate-swp" . " Exists"
        "echoerr "merda"
    endif
endfunction

augroup txt
au!
autocmd BufRead,BufNewFile *.txt call pencil#init()
augroup END

augroup markdown
au!
autocmd BufRead,BufNewFile *.md call pencil#init()
autocmd BufRead,BufNewFile *.md setlocal conceallevel=0
autocmd BufRead,BufNewFile *.md let g:prettier#config#tab_width = 1
augroup END

"------------------------------------------------------------------------------
" FILE GROUPS
"------------------------------------------------------------------------------

augroup makable
au!
autocmd BufRead    *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F2> :Make<CR>
autocmd BufNewFile *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F2> :Make<CR>
autocmd BufEnter   *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F2> :Make<CR>
autocmd BufRead    *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F5> :make clean<NL>
autocmd BufNewFile *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F5> :make clean<NL>
autocmd BufEnter   *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F5> :make clean<NL>
augroup END
