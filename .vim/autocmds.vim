"
" et: expandtab
" ic: ignorecase
" tw: textwidth

"------------------------------------------------------------------------------
" FILETYPES
"------------------------------------------------------------------------------


augroup CSELabCppfiles
au!
autocmd BufRead,BufNewFile,BufEnter *.cpp,*.h,*.hpp setlocal tw=80 cin noic autowrite
autocmd BufRead,BufNewFile,BufEnter *.cpp,*.h,*.hpp setlocal expandtab shiftwidth=4 tabstop=4
augroup END

augroup f77
au!
autocmd BufRead,BufNewFile,BufEnter *.f setlocal tw=80 autowrite ic et syntax=fortran
augroup END

augroup usr
au!
autocmd BufRead,BufNewFile,BufEnter *.usr    setlocal tw=0 autowrite ic et syntax=fortran
autocmd BufRead,BufNewFile,BufEnter *.upar   setlocal tw=0 autowrite ic et syntax=fortran
autocmd BufRead,BufNewFile,BufEnter SIZE     setlocal tw=0 autowrite ic et syntax=fortran
autocmd BufRead,BufNewFile,BufEnter USERPAR  setlocal tw=0 autowrite ic et syntax=fortran
autocmd BufRead,BufNewFile,BufEnter CHKPOINT setlocal tw=0 autowrite ic et syntax=fortran
augroup END

augroup f90
au!
autocmd BufRead,BufNewFile,BufEnter *.f90 setlocal tw=0 ic autowrite et
autocmd BufRead,BufNewFile,BufEnter *.f90 call SaneFortran('f95') 
augroup END

augroup tex
au!
autocmd BufRead,BufNewFile,BufEnter *.tex setlocal noic autowrite cc=81 "spell
autocmd BufRead,BufNewFile,BufEnter *.tex call pencil#init()
autocmd BufRead,BufNewFile,BufEnter *.tex setlocal conceallevel=0
"autocmd BufRead,BufNewFile,BufEnter *.tex imap <C-i> <Plug>IMAP_JumpForward
autocmd BufRead,BufNewFile,BufEnter *.tex nmap <C-i> <Plug>IMAP_JumpForward
"autocmd BufRead,BufNewFile,BufEnter *.tex iunmap <Tab>
autocmd BufRead,BufNewFile,BufEnter *.tex map <F2> <ESC>:w<CR><leader>ll
autocmd BufRead,BufNewFile,BufEnter *.tex map <F3> <ESC>:w<CR><leader>lv
"
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
autocmd BufRead,BufNewFile,BufEnter *.tex setlocal grepprg=grep\ -nH\ $*
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
autocmd BufRead,BufNewFile,BufEnter *.tex setlocal iskeyword+=:
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
autocmd BufRead,BufNewFile,BufEnter *.tex let g:tex_flavor='latex'
" tentative warning for kate-swp
"autocmd BufEnter *.tex call CheckKate()
augroup END

function CheckKate()
	if filereadable("." . expand('%:t') . ".kate-swp")
	"if filereadable(expand('%:p'))
		echoerr "." . expand('%:t') . ".kate-swp" . " Exists"
		"echoerr "merda"
	endif
endfunction

augroup pyton
au!
autocmd BufRead,BufNewFile,BufEnter *.py setlocal tw=0 noic autowrite
autocmd BufRead,BufNewFile,BufEnter *.py setlocal expandtab shiftwidth=4 tabstop=4
autocmd BufRead,BufNewFile,BufEnter *.py setlocal foldmethod=indent
autocmd BufRead,BufNewFile,BufEnter *.py setlocal foldlevel=99
"autocmd BufRead,BufNewFile,BufEnter *.py setlocal omnifunc=pythoncomplete#Complete
"autocmd BufRead,BufNewFile,BufEnter *.py setlocal completeopt=menuone,longest,preview
augroup END

augroup txt
au!
"autocmd BufRead,BufNewFile,BufEnter *.txt setlocal spell
autocmd BufRead,BufNewFile,BufEnter *.txt call pencil#init()
augroup END

augroup markdown
au!
autocmd BufRead,BufNewFile,BufEnter *.md call pencil#init()
autocmd BufRead,BufNewFile,BufEnter *.md setlocal conceallevel=0
augroup END

augroup edp
au!
autocmd BufRead,BufNewFile,BufEnter *.edp setf edp
augroup END

"------------------------------------------------------------------------------
" FILE GROUPS
"------------------------------------------------------------------------------

augroup makable
au!
autocmd BufRead *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F2> :make<CR>
autocmd BufNewFile *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F2> :make<CR>
autocmd BufEnter *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F2> :make<CR>
autocmd BufRead *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F5> :make clean<NL>
autocmd BufNewFile *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F5> :make clean<NL>
autocmd BufEnter *.c,*.cc,*.C,*.cpp,*.h,*.hpp,*.l,*.y,*.f,*.f90 map <F5> :make clean<NL>
augroup END

augroup scripts
au!
"autocmd BufRead,BufNewFile,BufEnter *.pl setlocal tw=0 smartindent noic 
"autocmd BufRead,BufNewFile,BufEnter *.py setlocal tw=0 smartindent noic "ts=3 sw=3
augroup END

