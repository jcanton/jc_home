"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
" Sections:
"    -> Vim-plug
"    -> Vim Addon Manager
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Text, tab and indent related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> miniBuf
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
call plug#end()


"------------------------------------------------------------------------------
" => Vim Addon Manager
"------------------------------------------------------------------------------

set nocompatible | filetype indent plugin on | syn on

fun! EnsureVamIsOnDisk(plugin_root_dir)
	" windows users may want to use http://mawercer.de/~marc/vam/index.php
	" to fetch VAM, VAM-known-repositories and the listed plugins
	" without having to install curl, 7-zip and git tools first
	" -> BUG [4] (git-less installation)
	let vam_autoload_dir = a:plugin_root_dir.'/vim-addon-manager/autoload'
	if isdirectory(vam_autoload_dir)
		return 1
	else
		if 1 == confirm("Clone VAM into ".a:plugin_root_dir."?","&Y\n&N")
			" I'm sorry having to add this reminder. Eventually it'll pay off.
			call confirm("Remind yourself that most plugins ship with ".
			            \"documentation (README*, doc/*.txt). It is your ".
			            \"first source of knowledge. If you can't find ".
			            \"the info you're looking for in reasonable ".
			            \"time ask maintainers to improve documentation")
			call mkdir(a:plugin_root_dir, 'p')
			execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.
			            \ shellescape(a:plugin_root_dir, 1).'/vim-addon-manager'
			" VAM runs helptags automatically when you install or update
			" plugins
			exec 'helptags '.fnameescape(a:plugin_root_dir.'/vim-addon-manager/doc')
		endif
		return isdirectory(vam_autoload_dir)
	endif
endfun

fun! SetupVAM()
	" Set advanced options like this:
	" let g:vim_addon_manager = {}
	" let g:vim_addon_manager.key = value
	"     Pipe all output into a buffer which gets written to disk
	" let g:vim_addon_manager.log_to_buf =1
	"
	" Example: drop git sources unless git is in PATH. Same plugins can
	" be installed from www.vim.org. Lookup MergeSources to get more control
	" let g:vim_addon_manager.drop_git_sources = !executable('git')
	" let g:vim_addon_manager.debug_activation = 1

	" VAM install location:
	let c = get(g:, 'vim_addon_manager', {})
	let g:vim_addon_manager = c
	let c.plugin_root_dir = expand('$HOME/.vim/vim-addons', 1)
	if !EnsureVamIsOnDisk(c.plugin_root_dir)
		echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
		return
	endif
	let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'

	" Tell VAM which plugins to fetch & load:
	" call vam#ActivateAddons([], {'auto_install' : 0})
	" sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
	" Also See "plugins-per-line" below
	call vam#ActivateAddons([], {})
	"
	" vim-pi: vim plugin index, lists all known vim plugins
	ActivateAddons vim-pi
	"
	" some utility libraries
	ActivateAddons tlib vim-addon-mw-utils
	"
	" snippets
	ActivateAddons snipmate vim-snippets
	" ActivateAddons UltiSnips vim-snippets (python-based alternative which I do not like)
	"
	" LaTeX Suite
	" FUCKING FUCK seems not to be cloning anymore
	ActivateAddons LaTeX-Suite_aka_Vim-LaTeX
	"
	" File browser
	ActivateAddons The_NERD_tree
	"
	" Mini Buffer tabs
	"ActivateAddons minibufexplorer
	"
	" Syntax colors
	ActivateAddons python%790
	"
	" Additional indentation rules
	ActivateAddons fortran
	"
	" Color schemes
	"ActivateAddons Solarized
	"
	" Vim Pencil
	ActivateAddons vim-pencil


	" Addons are put into plugin_root_dir/plugin-name directory
	" unless those directories exist. Then they are activated.
	" Activating means adding addon dirs to rtp and do some additional
	" magic

	" How to find addon names?
	" - look up source from pool
	" - (<c-x><c-p> complete plugin names):
	" You can use name rewritings to point to sources:
	" ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
	" ..ActivateAddons(["github:user/repo", .. => github://user/repo
	" Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun

call SetupVAM()
" experimental [E1]: load plugins lazily depending on filetype, See
" NOTES
" experimental [E2]: run after gui has been started (gvim) [3]
" option1: au VimEnter * call SetupVAM()
" option2: au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
" Vim 7.0 users see BUGS section [3]

"------------------------------------------------------------------------------
" => General
"------------------------------------------------------------------------------

" Do not wait after a keystroke if there is no command defined with that key
" as first
set ttimeoutlen=0

" Always autosave everything when focus is lost
:au FocusLost * :wa

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins (already enabled for vim-addon-manager)
"filetype plugin on
"filetype indent on

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

"  " Changing the cursor shape between insert and normal mode
"  if &term =~ "xterm\\|rxvt"
"    " use an blue cursor in insert mode
"    let &t_SI = "\<Esc>]12;blue\x7"
"    " use a red cursor otherwise
"    let &t_EI = "\<Esc>]12;red\x7"
"    silent !echo -ne "\033]12;red\007"
"    " reset cursor when vim exits
"    autocmd VimLeave * silent !echo -ne "\003]12;gray\007"
"  endif

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
	colorscheme base16-solarized-dark
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
" set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab = 3 spaces
set shiftwidth=3
set tabstop=3

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
" MiniBufExplorer and NERDtree
"------------------------------------------------------------------------------

"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1 

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

"-------------------------------------------------------------------------------
" Fortran stuff

function SaneFortran (foo)
    if a:foo == 'f95'
        let g:fortran_have_tabs=1
        let g:fortran_more_precise=1
        let b:fortran_free_source=1
        let b:fortran_fixed_source=0
        let b:fortran_dialect="f95"
        let b:fortran_do_enddo=1
        source $HOME/.vim/vim-addons/fortran/indent/fortran.vim
    else
        unlet! fortran_free_source
    endif
    return 0
endfunction

"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
if filereadable(glob("$HOME/.vimrc.local"))
   source $HOME/.vimrc.local
endif
