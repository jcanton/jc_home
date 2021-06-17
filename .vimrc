"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
" Sections:
"    -> Vim-plug
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Text, tab and indent related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> The NERDTree
"    -> The NERDCommenter
"    -> Terminal
"    -> Markdown preview
"    -> CoC configuration
"    -> Project dependent options
"    -> File specific autocmds
"    -> Local vimrc
"
"    take a look at this when you have the time
"    https://github.com/nathanaelkane/vim-indent-guides
"
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
" Set location of vimDir
let vimDir = '$HOME/.vim'
if stridx(&runtimepath, expand(vimDir)) == -1
  " vimDir is not on runtimepath, add it
  let &runtimepath.=','.vimDir
endif

"------------------------------------------------------------------------------
" => Vim-plug
"------------------------------------------------------------------------------
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'chriskempson/base16-vim' " Base16 for Vim
Plug 'tpope/vim-obsession' " Continuously updated session files
Plug 'gcmt/taboo.vim' " Few utilities for pretty tabs (including rename)
Plug 'ikicic/vim-tmux-navigator' " vim-tmux navigation integration
Plug 'roxma/vim-tmux-clipboard' " copy to clipboard working well (depends on vim-tmux-focus-events)
Plug 'tmux-plugins/vim-tmux-focus-events' " needs `set -g focus-events on` in tmux.conf
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes' " This is the official theme repository for vim-airline
Plug 'reedes/vim-pencil' " Rethinking Vim as a tool for writers
Plug 'octol/vim-cpp-enhanced-highlight' " Additional C++ syntax highlighting
Plug 'rhysd/vim-clang-format' " Vim plugin for clang-format, a formatter for C, C++, Obj-C, Java, JavaScript etc.
Plug 'tpope/vim-repeat' " enable repeating supported plugin maps with .
Plug 'tpope/vim-dispatch' " Asynchronous build and test dispatcher
Plug 'ctrlpvim/ctrlp.vim' " Full path fuzzy file, buffer, mru, tag, ... finder for Vim
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'preservim/nerdtree' " The NERDTree
Plug 'tpope/vim-commentary' " Comment stuff out
Plug 'tpope/vim-fugitive' " A Git wrapper so awesome, it should be illegal
Plug 'Xuyuanp/nerdtree-git-plugin' " Plugin for git colors in NERDTree
Plug 'airblade/vim-gitgutter' " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks and partial hunks.
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Extra syntax and highlight for nerdtree files
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'preservim/tagbar' " Tagbar: a class outline viewer for Vim
Plug 'luochen1990/rainbow' " Rainbow Parentheses Improved
Plug 'kshenoy/vim-signature' " Marks on the left side
Plug 'yilin-yang/vim-markbar' " Mark-bar
"
Plug 'ryanoasis/vim-devicons' " ALWAYS LOAD LAST Adds file type icons to Vim plugins
Plug 'honza/vim-snippets'  " snippets for the engines (somehow disappeared from CoC - seems to be back now, but not working without this?)
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
"
"------------------------------------------------------------------------------
" Functions
"------------------------------------------------------------------------------

" Enhanced add/subtract
function! AddSubtract(char, back)
    let pattern = &nrformats =~ 'alpha' ? '[[:alpha:][:digit:]]' : '[[:digit:]]'
    call search(pattern, 'cw' . a:back)
    execute 'normal! ' . v:count1 . a:char
    silent! call repeat#set(":\<C-u>call AddSubtract('" .a:char. "', '" .a:back. "')\<CR>")
endfunction

" Delete all trailing whitespaces
function! DeleteTrailingWhitespace()
    %s/\s\+$//e
    echo "Deleted trailing whitespaces"
endfunction
command! DeleteTrailingWhitespace call DeleteTrailingWhitespace()

" Delete hidden buffers
function! DeleteHiddenBuffers()
    let tpbl=[]
    let closed = 0
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        if getbufvar(buf, '&mod') == 0
            silent execute 'bwipeout' buf
            let closed += 1
        endif
    endfor
    echo "Closed ".closed." hidden buffers"
endfunction
command! DeleteHiddenBuffers call DeleteHiddenBuffers()

" Compile stuff
function! CompileStuff()
    let current_filetype = &filetype
    echo current_filetype
    echo @%
    :update<CR>
    if current_filetype == "python"
        :!python3 %
    else
        :make
    endif
endfunction
command! CompileStuff call CompileStuff()


"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------

" Default splits below and to the right
set splitbelow
set splitright

" Do not wait after a keystroke if there is no command defined with that key
" as first
" set ttimeoutlen=0
" set timeoutlen=1000 ttimeoutlen=0


" Always autosave everything when focus is lost
:au FocusLost * :wa

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins (already enabled for vim-addon-manager)
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Enable extended % matching (make it work with if/elseif/else/end)
runtime macros/matchit.vim

" Make undo be usable after closing the file - from Chavo
" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    " define a path to store persistent_undo files.
    let persistentUndoDir = expand(vimDir . '/undo')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(persistentUndoDir)
        call system('mkdir -p ' . persistentUndoDir)
    endif
    " point Vim to the defined undo directory.
    let &undodir = persistentUndoDir
    " finally, enable undo persistence.
    set undofile
endif

" Turn on Rainbow parenthesis
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle


"------------------------------------------------------------------------------
" VIM user interface
"------------------------------------------------------------------------------

" Set 7 lines to the cursor - when moving vertically using j/k
" set so=7

" fix the window's width
" set columns=86

" turn on line numbers
set number

" show the command being typed
set showcmd

" do not wrap lines by default
set nowrap

" but default pencil to 'soft' if initialized
let g:pencil#wrapModeDefault = 'soft'

" highlight current line (slows down scrolling)
" set cursorline

" " some gui options (as hide menus)
" set guioptions=agirLM"mT
" set vb t_vb=

" display vertical bar at 81st column
" set cc=81
" hi ColorColumn guibg=lightGray

" use mouse everywhere
set mouse=a

" Turn on the WiLd menu
set wildmenu
" and make it behave like a shell
set wildmode=list:longest

"Always show current position
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" Stop highlighting matching parenthesis
" let loaded_matchparen = 1

" No annoying sound on errors
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"------------------------------------------------------------------------------
" Colors and Fonts
"------------------------------------------------------------------------------

" Enable syntax highlighting
syntax enable

" The following lines enable true color support
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Read base16-vim colorscheme
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=UTF-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"------------------------------------------------------------------------------
" Text, tab and indent related
"------------------------------------------------------------------------------

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4

" convert all tabs to spaces when opening a file that has tabs in it
" if has("autocmd")
"    au BufReadPost * if &modifiable | retab | endif
" endif

" add respace command to remove all trailing whitespaces
command! -nargs=0 Respace :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Linebreak makes vim break lines without cutting words in half
set linebreak
" Auto line break on 80th column
" set textwidth=80

"------------------------------------------------------------------------------
" Moving around, tabs, windows and buffers
"------------------------------------------------------------------------------
"
" Taboo is able to remember tab names when you save the current session but
" you are required to set the following option in your .vimrc file
set sessionoptions+=tabpages,globals

" Specify the behavior when switching between buffers
" try
"   set switchbuf=useopen,usetab,newtab
"   set stal=2
" catch
" endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

"------------------------------------------------------------------------------
" Status line
"------------------------------------------------------------------------------

" Enable/disable vim-obsession integration
let g:airline#extensions#obsession#enabled = 1

" Set obsession indicator string
let g:airline#extensions#obsession#indicator_text = '@o@'

" " Add support for bufferline (init function overridden in after/plugin)
" let g:airline#extensions#bufferline#enabled = 1
" let g:bufferline_echo = 0

" Configure tabline
" let g:taboo_tabline = 0 " First disable Taboo's tabline
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' ' " ''
" let g:airline#extensions#tabline#left_alt_sep = '' " '|'
" let g:airline#extensions#tabline#tab_nr_type = 1         " show tab numbers instead of number of buffers
" " let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
" " let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
" " let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
" " let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
" " let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
" " let g:airline#extensions#tabline#show_buffers = 1      " dont show buffers in the tabline
" " let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
" " let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
" " let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers
" " let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline

" Select vim-airline theme
let g:airline_theme='papercolor'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.whitespace = 'Ξ'
"✘   

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

"------------------------------------------------------------------------------
" NERDtree
"------------------------------------------------------------------------------


" open NERDTree automatically
" autocmd VimEnter * NERDTree | wincmd p

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" " Sync the open file with NERDTree
" " Check if NERDTree is open or active
" function! IsNERDTreeOpen()
"     return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
" endfunction
" " Call NERDTreeFind iff NERDTree is active, current window contains a
" " modifiable file, and we are not in vimdiff
" function! SyncTree()
"     if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"         NERDTreeFind
"         wincmd p
"     endif
" endfunction
" " Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()

"------------------------------------------------------------------------------
" Terminal configuration
"------------------------------------------------------------------------------


" Default to insert mode when opening a new term
autocmd TermOpen term://* startinsert

" " Default to insert mode when entering
" let g:previous_window = -1
" function SmartInsert()
"   if &buftype == 'terminal'
"     if g:previous_window != winnr()
"       startinsert
"     endif
"     let g:previous_window = winnr()
"   else
"     let g:previous_window = -1
"   endif
" endfunction
" au BufEnter * call SmartInsert()

"------------------------------------------------------------------------------
" Prettier configuration
"------------------------------------------------------------------------------

" Max line length that prettier will wrap on: a number or 'auto' (use textwidth).
" default: 'auto'
let g:prettier#config#print_width = 'auto'

" number of spaces per indentation level: a number or 'auto' (use softtabstop)
" default: 'auto'
let g:prettier#config#tab_width = 4

" use tabs instead of spaces: true, false, or auto (use the expandtab setting).
" default: 'auto'
let g:prettier#config#use_tabs = 'false'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown or empty string
" (let prettier choose).
" default: ''
let g:prettier#config#parser = ''

"------------------------------------------------------------------------------
" Vimtex configuration
"------------------------------------------------------------------------------
let g:tex_flavor = 'latex'

"------------------------------------------------------------------------------
" Load CoC configuration
"------------------------------------------------------------------------------
if filereadable(glob("$HOME/.vim/coc-config.vim"))
   source $HOME/.vim/coc-config.vim
endif

"------------------------------------------------------------------------------
" Project dependent options
"------------------------------------------------------------------------------
" This allows per-project configuration files by reading .vimrc files in
" non-home folders

set exrc
set secure

"------------------------------------------------------------------------------
" All my mappings
"------------------------------------------------------------------------------

if filereadable(glob("$HOME/.vim/mappings.vim"))
   source $HOME/.vim/mappings.vim
endif

"------------------------------------------------------------------------------
" File specific autocmds
"------------------------------------------------------------------------------

if has("autocmd")
    if filereadable(glob("$HOME/.vim/autocmds.vim"))
        source $HOME/.vim/autocmds.vim
    endif
endif

"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
if filereadable(glob("$HOME/.vimrc.local"))
   source $HOME/.vimrc.local
endif
