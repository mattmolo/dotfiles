""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filename: .vimrc                                                           "
"                                                                            "
" Sections:                                                                  "
"   Vundle .................. Setup Vundle at start                          "
"   General ................. General Vim behavior                           "
"   Theme/Colors ............ Colors, fonts, etc.                            "
"   Vim UI .................. User interface behavior                        "
"   Remaps .................. Key and command remaps						 "
"   Text Formatting/Layout .. Text, tab, indentation related                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically setup Vundle on first run

if !isdirectory(expand("~/.vim/bundle/vundle"))
	call system("git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle")
endif

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle

call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'cohama/lexima.vim'
Plugin 'scrooloose/syntastic'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mbbill/undotree'
Plugin 'nvie/vim-togglemouse'
Plugin 'mattn/emmet-vim'

if has("Lua")
	Plugin 'Shougo/neocomplete.vim'
endif

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" get rid of Vi compatibility mode.
set nocompatible

" keep persistent_undo
if has("persistent_undo")
	silent call system('mkdir -p ~/.vimundo')
	set undodir=~/.vimundo/
	set undofile
endif

if &term =~ '256color'
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

" open help in vertical split
augroup vimrc_help
	autocmd!
	autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
	augroup END
augroup END

set timeoutlen=1000 ttimeoutlen=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme/Colors                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).

if isdirectory(expand("~/.vim/bundle/papercolor-theme/colors"))
	set background=dark
	colorscheme PaperColor
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                " show line numbers
set cul                   " highlight current line
set wildmenu              " tab completion
set wildignore=*.o,*~     " ignore things
set laststatus=2          " always show status line
set nohlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set showmatch             " show matching brackets
set mat=1                 " tenths of a second to blink between matching brackets
set mouse=a               " turn mouse mode on

set splitbelow            " Split (sp) below
set splitright            " Split (vsp) to the right


" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let mapleader = "\<Space>"
" map seems to be nicer than mapleader
map <Space> <Leader>

" map C-nav keys to move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" faster than reaching for escape
inoremap <C-j> <ESC>

" lots of faster save methods
" can't decide on favorite so there are many
" :w, q, q!, x remaps 
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>1 :q!<CR>
nnoremap <Leader>x :wq<CR>

nnoremap <Esc>w :w<CR>
nnoremap <Esc>q :q<CR>
nnoremap <Esc>1 :q!<CR>
nnoremap <Esc>x :wq<CR>

nnoremap S :w<CR>
nnoremap X :x<CR>

" faster pane switching
nnoremap <C-w> <C-w><C-w>

" faster movement through file 
nnoremap <Leader>j <C-d>
nnoremap <Leader>k <C-u>

" q: typo
nnoremap q: :q

" move to end of line with H and L
" Takes over H (move to top of screen) and L (move to bottom of screen)
nnoremap <Leader>h 0
nnoremap <Leader>l $

" NERDCommentToggle, can't be nore for some reason
nmap <Leader>, <Plug>NERDCommenterToggle
vmap <Leader>, <Plug>NERDCommenterToggle

" Faster :
nnoremap <Leader>; <Esc>:
vnoremap <Leader>; <Esc>:

" Fast replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Function key maps
"
" spellcheck
noremap <silent> <F1> :setlocal spell!<CR>
" quick rename (like file renaming for Windows)
nnoremap	<F2> ciw
vnoremap	<F2> c
" NERDTree
noremap <silent> <F3> :NERDTreeToggle<CR>
" UndoTree
noremap <silent> <F4> :UndotreeToggle<CR>
" paste mode
set pastetoggle=<F6>
nnoremap <F6> :set paste<CR>o
" Set numbers (easier copy)
noremap <silent> <F7> :set nu!<CR> :GitGutterToggle<CR>


" display tbas as a bar (works okay)
"noremap <silent> <F3> :setlocal list!<CR>
"set list
"set list lcs=tab:\┆\ 

" Remove trailing whitespaces
nnoremap <silent> <Leader><BS> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:w<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" json pretty
command -nargs=* JSON %!python -m json.tool


" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap                  " do not wrap text
set scrolloff=5             " keep minimal number of lines above/below cursor
set showcmd                 " show command line at bottom of screen
set sidescroll=3            " scroll sideways 3 characters at a time

set backspace=2             " make backspace behave normally
"set expandtab              " insem tabs as spaces
set shiftwidth=4            " number of spaces for auto indent and line shift
set cindent                 " syntax-aware auto indent
set smarttab                " <BS> deletes a shiftwidth worth of space
set softtabstop=4           " number of spaces pressing <Tab> counts for
set tabstop=4               " number of spaces a <Tab> in the file counts for
set linebreak               " break on whitespace, not words
if v:version >= 704
    set breakindent         " preserve indentation on wrap
endif

set encoding=utf-8          " defualt text mode

" Folding: allow fold but not auto
set foldmethod=syntax
set foldlevelstart=99

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_fold=1                " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML


" In Makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif
" Remember info about open buffers on close
set viminfo^=%


" Enable Spell Checking for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.markdown setlocal spell

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-easy-align"))
	nnoremap <Leader>a <Plug>(EasyAlign)
endif

if isdirectory(expand("~/.vim/bundle/nerdtree"))
	nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
endif

if isdirectory(expand("~/.vim/bundle/vim-airline"))
	let g:airline_left_sep=''
	let g:airline_right_sep=''
	let g:airline#extensions#whitespace#enabled = 0
endif

if isdirectory(expand("~/.vim/bundle/vim-go"))
	au FileType go nmap <Leader>gr <Plug>(go-run)
	au FileType go nmap <Leader>gb <Plug>(go-build)
	au FileType go nmap <Leader>gd <Plug>(go-doc-vertical)
	au FileType go nmap <Leader>gi <Plug>(go-info)
	au FileType go nmap <Leader>gn <Plug>(go-rename)

	let g:go_highlight_functions = 1
	let g:go_highlight_methods = 1
	let g:go_highlight_structs = 1
	let g:go_highlight_operators = 1
	let g:go_highlight_build_constraints = 1
endif

if isdirectory(expand("~/.vim/bundle/tagbar"))
	nmap <Leader>t :TagbarToggle<CR>
	let g:tagbar_type_go = {  
		\ 'ctagstype' : 'go',
		\ 'kinds'     : [
			\ 'p:package',
			\ 'i:imports:1',
			\ 'c:constants',
			\ 'v:variables',
			\ 't:types',
			\ 'n:interfaces',
			\ 'w:fields',
			\ 'e:embedded',
			\ 'm:methods',
			\ 'r:constructor',
			\ 'f:functions'
			\ ],
		\ 'sro' : '.',
		\ 'kind2scope' : {
			\ 't' : 'ctype',
			\ 'n' : 'ntype'
		\ },
		\ 'scope2kind' : {
			\ 'ctype' : 't',
			\ 'ntype' : 'n'
		\ },
		\ 'ctagsbin'  : 'gotags',
		\ 'ctagsargs' : '-sort -silent'
	\ }
endif

if isdirectory(expand("~/.vim/bundle/neocomplete.vim"))
	if has("Lua") 
		let g:neocomplete#enable_at_startup = 1
		let g:neocomplete#enable_smart_case = 1
	endif 
endif


"if isdirectory(expand("~/.vim/bundle/emmet-vim"))
	"let g:user_emmet_leader_key='<C-d>'
"endif
