"===============================================================================
" Vim mappings
"===============================================================================

" Open this file
noremap <M-m> :exec 'pedit $HOME/.vim/mappings.vim'<CR>

" Remap pasting to the blackhole register
vnoremap p "_dP

" " Remap deleting to the blackhole register
" nnoremap x "_x
" vnoremap x "_x
" nnoremap d "_d
" vnoremap d "_d
" nnoremap D "_D
" nnoremap <leader>d ""d
" vnoremap <leader>d ""d
" nnoremap <leader>x ""x
" vnoremap <leader>x ""x
" nnoremap <leader>D ""D

"-------------------------------------------------------------------------------
" Function calls
"-------------------------------------------------------------------------------

" Enhanced add/subtract
" Cannot get this to work as I want for now
nnoremap <silent>         <M-]> :<C-u>call AddSubtract("\<C-a>", '')<CR>
nnoremap <silent> <Leader><M-]> :<C-u>call AddSubtract("\<C-a>", 'b')<CR>
nnoremap <silent>         <M-[> :<C-u>call AddSubtract("\<C-x>", '')<CR>
nnoremap <silent> <Leader><M-[> :<C-u>call AddSubtract("\<C-x>", 'b')<CR>

" Delete all trailing whitespaces
map <M-s> :DeleteTrailingWhitespace<CR>
" autocmd BufWritePre * %s/\s\+$//e

" Delete hidden buffers
map <M-d> :DeleteHiddenBuffers<CR>

" Compile stuff
map <F2> :CompileStuff<CR>

"-------------------------------------------------------------------------------
" Plugin calls
"-------------------------------------------------------------------------------

" fugitive shortcuts
command! Gic :Git commit
command! Gip :Git push

" tagbar - a plugin that provides code overview, you need to install ctags for it
nmap <M-t> :TagbarToggle<CR>

" Convenient obsession mapping
noremap <M-o> :Obsession<CR>

" NERDtree
noremap <C-n> :NERDTreeToggle<CR>

" Prettier
nmap <space>p :Prettier<CR>

" " Some tabs/Taboo mappings
" map <M-]> :tabnext<CR>
" map <M-[> :tabprevious<CR>
" map <M-c> :TabooOpen
" map <M-r> :TabooRename
" map <M-R> :TabooReset<CR>

"-------------------------------------------------------------------------------
" 'Normal' mappings
"-------------------------------------------------------------------------------

" Use `Ctrl+{h,j,k,l}` to navigate windows from any mode
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Maps for splitting
tnoremap <M-j> :sp<CR>
inoremap <M-j> :sp<CR>
nnoremap <M-j> :sp<CR>
tnoremap <M-k> :vs<CR>
inoremap <M-k> :vs<CR>
nnoremap <M-k> :vs<CR>

" " Moving lines (I never use this)
" nnoremap <M-j> :m .+1<CR>==
" nnoremap <M-k> :m .-2<CR>==
" inoremap <M-j> <Esc>:m .+1<CR>==gi
" inoremap <M-k> <Esc>:m .-2<CR>==gi
" vnoremap <M-j> :m '>+1<CR>gv=gv
" vnoremap <M-k> :m '<-2<CR>gv=gv

" Force redraw
nnoremap <M-l> :redraw!<CR>

" Treat long lines as break lines (useful when moving around in them)
" map j gj
" map k gk
" substituted with Pencil

" Conflicts with other mappings
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" noremap <space> /
" noremap <c-space> ?

" Disable highlight when <leader><cr> is pressed
noremap <silent> <leader><cr> :noh<cr>
noremap <silent> <space><cr> :noh<cr>

" Close the current buffer
" map <leader>bd :Bclose<cr>

" Close all the buffers
" map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
" map <C-a>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <M>cd :cd %:p:h<cr>:pwd<cr>

" Return to normal mode with Esc (in terminal)
tnoremap <Esc> <C-\><C-n>

"-------------------------------------------------------------------------------
" Coc
"-------------------------------------------------------------------------------

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" And use <Tab> and <S-Tab> to navigate the completion list:
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" " Mappings using CoCList:
" " Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"===============================================================================

" Open this file
noremap <M-m> :exec 'pedit $HOME/.vim/mappings.vim'<CR>
