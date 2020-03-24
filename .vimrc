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
"------------------------------------------------------------------------------
" => Vim-plug
"------------------------------------------------------------------------------
call plug#begin()
Plug 'chriskempson/base16-vim' " Base16 for Vim
Plug 'tpope/vim-obsession' " Continuously updated session files
"Plug 'bling/vim-bufferline' " Super simple vim plugin to show the list of buffers in the command bar.
Plug 'ikicic/vim-tmux-navigator' " vim-tmux navigation integration
Plug 'roxma/vim-tmux-clipboard' " copy to clipboard working well (depends on vim-tmux-focus-events)
Plug 'tmux-plugins/vim-tmux-focus-events' " needs `set -g focus-events on` in tmux.conf
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes' " This is the official theme repository for vim-airline
Plug 'lervag/vimtex' " let's try this latex plugin
Plug 'reedes/vim-pencil' " Rethinking Vim as a tool for writers
Plug 'octol/vim-cpp-enhanced-highlight' " Additional C++ syntax highlighting
" Plug 'jackguo380/vim-lsp-cxx-highlight' " maybe in alternative to the one above but fucks up colors
Plug 'rhysd/vim-clang-format' " Vim plugin for clang-format, a formatter for C, C++, Obj-C, Java, JavaScript etc.
Plug 'nvie/vim-flake8' " Flake8 plugin for Vim. Press <F7> to run flake8
Plug 'tpope/vim-dispatch' " Asynchronous build and test dispatcher
Plug 'ctrlpvim/ctrlp.vim' " Full path fuzzy file, buffer, mru, tag, ... finder for Vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree' " The NERDTree
Plug 'preservim/nerdcommenter' " The NERDcommenter
Plug 'tpope/vim-fugitive' " A Git wrapper so awesome, it should be illegal
Plug 'Xuyuanp/nerdtree-git-plugin' " Plugin for git colors in NERDTree
Plug 'airblade/vim-gitgutter' " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks and partial hunks.
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Extra syntax and highlight for nerdtree files
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
"
Plug 'ryanoasis/vim-devicons' " ALWAYS LOAD LAST Adds file type icons to Vim plugins
" Plug 'neomake/neomake' " Neomake is a plugin for Vim/Neovim to asynchronously run programs (propably needed for synctex, maybe not)
" Plug 'dense-analysis/ale' " Asynchronous Lint Engine Substituted  with CoC
" next two are now in CoC
" Plug 'SirVer/ultisnips' " UltiSnips is the ultimate solution for snippets in Vim. It has tons of features and is very fast.
" Plug 'honza/vim-snippets'  " snippets for the engine above
call plug#end()

"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------

" Remove all trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e

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

" Default splits below and to the right
set splitbelow
set splitright

" Maps for splitting
tnoremap <C-a>j :sp<CR>
inoremap <C-a>j :sp<CR>
nnoremap <C-a>j :sp<CR>
tnoremap <C-a>k :vs<CR>
inoremap <C-a>k :vs<CR>
nnoremap <C-a>k :vs<CR>

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


" Moving lines
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

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

" Force redraw with C-l
noremap <c-l> :redraw!<CR>

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
" map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
" map <leader>cd :cd %:p:h<cr>:pwd<cr>

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

" Add support for bufferline (init function overridden in after/plugin)
let g:airline#extensions#bufferline#enabled = 1
let g:bufferline_echo = 0

" " Configure tabline - actually USE BUFFERS INSTEAD
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' ' " ''
" let g:airline#extensions#tabline#left_alt_sep = '|' " ''
" let g:airline#extensions#tabline#tab_nr_type = 1         " show tab numbers instead of number of buffers
" " let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
" " let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
" " let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
" " let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
" " let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
" let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
" let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
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

" Re-map NERDtree
noremap <C-n> :NERDTreeToggle<CR>

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
" NERDCommenter
"------------------------------------------------------------------------------
vmap <Space>/ <plug>NERDCommenterToggle
nmap <Space>/ <plug>NERDCommenterToggle

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

"------------------------------------------------------------------------------
" Terminal configuration
"------------------------------------------------------------------------------

" Return to normal mode with Esc
tnoremap <Esc> <C-\><C-n>

" Default to insert mode when entering
let g:previous_window = -1
function SmartInsert()
  if &buftype == 'terminal'
    if g:previous_window != winnr()
      startinsert
    endif
    let g:previous_window = winnr()
  else
    let g:previous_window = -1
  endif
endfunction
au BufEnter * call SmartInsert()
autocmd TermOpen term://* startinsert

"------------------------------------------------------------------------------
" Prettier configuration
"------------------------------------------------------------------------------
nmap <space>p :Prettier<CR>

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
" MarkdownPreview configuration
"------------------------------------------------------------------------------
if filereadable(glob("$HOME/.vim/markdown-preview-config.vim"))
   source $HOME/.vim/markdown-preview-config.vim
endif

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
