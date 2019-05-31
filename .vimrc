"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
" Sections:
"    -> Vim-plug
"    -> Utilsnips
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Text, tab and indent related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> The NERDTree
"    -> File specific autocmds
"    -> Fortran stuff
"
"    take a look at this when you have the time
"    https://github.com/nathanaelkane/vim-indent-guides
"
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
"------------------------------------------------------------------------------
" very controversial test:
"------------------------------------------------------------------------------
"noremap ; l
"noremap l k
"noremap k j
"noremap j h

" Smart way to move between windows
noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l
"noremap <C-;> <C-W>;

"------------------------------------------------------------------------------
" => Vim-plug
"------------------------------------------------------------------------------
call plug#begin()
Plug 'ikicic/vim-tmux-navigator' " vim-tmux navigation integration
"Plug 'fcpg/vim-osc52' " test copy to clipboard not really working well
Plug 'roxma/vim-tmux-clipboard' " copy to clipboard working well (depends on vim-tmux-focus-events)
Plug 'tmux-plugins/vim-tmux-focus-events' " needs `set -g focus-events on` in tmux.conf
Plug 'lervag/vimtex' " let's try this latex plugin
Plug 'w0rp/ale' " Asynchronous Lint Engine
Plug 'neomake/neomake' " Neomake is a plugin for Vim/Neovim to asynchronously run programs
" Plug 'lambdalisue/vim-pyenv' " See if this fixes pyenv issues
Plug 'SirVer/ultisnips' " UltiSnips is the ultimate solution for snippets in Vim. It has tons of features and is very fast.
Plug 'honza/vim-snippets'  " snippets for the engine above
Plug 'ludovicchabant/vim-gutentags' " Gutentags is a plugin that takes care of the much needed management of tags files in Vim
Plug 'scrooloose/nerdtree' " The NERDTree
Plug 'reedes/vim-pencil' " Rethinking Vim as a tool for writers
call plug#end()

"------------------------------------------------------------------------------
" => Utilsnips
"------------------------------------------------------------------------------

" Directories for the snippets:
let g:UltiSnipsSnippetDirectories=["ultiSnips"]

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"------------------------------------------------------------------------------
" => gutentags
"------------------------------------------------------------------------------

let g:gutentags_project_root = ['.git', '.svn', '.root', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q', '--c++-kinds=+px', '--c-kinds=+px']
" let g:gutentags_trace = 1
let g:gutentags_file_list_command = {
            \  'markers': {
                \  '.git': 'git ls-files',
                \  '.hg': 'hg files',
                \  }
            \  }

"------------------------------------------------------------------------------
" => General
"------------------------------------------------------------------------------

" Do not wait after a keystroke if there is no command defined with that key
" as first
" set ttimeoutlen=0
set timeoutlen=1000 ttimeoutlen=0


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

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
" let mapleader = ","
" let g:mapleader = ","

" Fast saving
" nmap <leader>w :w!<cr>

" Moving lines
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

"------------------------------------------------------------------------------
" => VIM user interface
"------------------------------------------------------------------------------

" Changing the cursor shape between insert and normal mode
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\" 


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

" some gui options (as hide menus)
set guioptions=agirLM"mT
set vb t_vb=

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

" Height of the command bar
" set cmdheight=2

" A buffer becomes hidden when it is abandoned
" set hid

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
" set noerrorbells
" set novisualbell
" set t_vb=
" "set tm=500
" if has("gui_running")
" 	set vb t_vb=
" endif
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


"------------------------------------------------------------------------------
" => Colors and Fonts
"------------------------------------------------------------------------------

" Enable syntax highlighting
syntax enable

" Set extra options when running in GUI mode
if has("gui_running")
	set guioptions-=T
	set guioptions+=e
	set guitablabel=%M\ %t
	" set t_Co=256
	"
	" base16 configuration
	let base16colorspace=256
	colorscheme base16-solarized-light
	" alternative Solarized addon
	" colorscheme solarized
else
	let base16colorspace=256
	if filereadable(expand("~/.vimrc_background"))
		source ~/.vimrc_background
	else
		colorscheme base16-xcode-dusk
	endif
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"------------------------------------------------------------------------------
" => Text, tab and indent related
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

" Linebreak makes vim break lines without cutting words in half
set linebreak
" Auto line break on 80th column
" set textwidth=80

"------------------------------------------------------------------------------
" => Moving around, tabs, windows and buffers
"------------------------------------------------------------------------------

" Treat long lines as break lines (useful when moving around in them)
" map j gj
" map k gk
" substituted with Pencil

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
noremap <space> /
noremap <c-space> ?

" Disable highlight when <leader><cr> is pressed
noremap <silent> <leader><cr> :noh<cr>

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
" => Status line
"------------------------------------------------------------------------------

" Always show the status line
"set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"------------------------------------------------------------------------------
" NERDtree
"------------------------------------------------------------------------------

" Re-map NERDtree
noremap <C-n> :NERDTreeToggle<CR>

" Change colour for directories
" hi Directory guifg=#FF0000 ctermfg=red

"------------------------------------------------------------------------------
" File dependent options
"------------------------------------------------------------------------------

if has("autocmd")
	if filereadable(glob("$HOME/.vim/autocmds.vim"))

		source $HOME/.vim/autocmds.vim

	endif
endif

"------------------------------------------------------------------------------
" Project dependent options
"------------------------------------------------------------------------------
" This allows per-project configuration files by reading .vimrc files in
" non-home folders

set exrc
set secure

"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
if filereadable(glob("$HOME/.vimrc.local"))
   source $HOME/.vimrc.local
endif
