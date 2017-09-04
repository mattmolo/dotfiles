""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filename: .vimrc                                                           "
"                                                                            "
" Sections:                                                                  "
"   Vundle .................. Setup Vundle at start                          "
"   General ................. General Vim behavior                           "
"   Theme/Colors ............ Colors, fonts, etc.                            "
"   Vim UI .................. User interface behavior                        "
"   Remaps .................. Key and command remaps                         "
"   Text Formatting/Layout .. Text, tab, indentation related                 "
"   Plugin Specific Config .. Configuration dependant on plugins             "
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

" Extended Features and Accessibility
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mbbill/undotree'
Plugin 'nvie/vim-togglemouse'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ConradIrwin/vim-bracketed-paste'

" Airline
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Themes and Aesthetics
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'mattmolo/vim-srcery-drk'

" GIT Help
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Nicer movements
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mattn/emmet-vim'
Plugin 'kana/vim-textobj-user'
Plugin 'jiangmiao/auto-pairs'

" Language Support
Plugin 'rust-lang/rust.vim' " Rust

Plugin 'kongo2002/fsharp-vim' " F#

Plugin 'fatih/vim-go' " Go

Plugin 'nvie/vim-flake8' " Python Linter
"Plugin 'davidhalter/jedi-vim' " Python

Plugin 'captbaritone/better-indent-support-for-php-with-html' " PHP + HTML
Plugin 'alvan/vim-closetag' " Close HTML Tags
Plugin 'benjifisher/matchit.zip' " Match HTML tags
Plugin 'pangloss/vim-javascript' " JS
Plugin 'isRuslan/vim-es6' " ES6
Plugin 'HerringtonDarkholme/yats.vim' " Typescript
Plugin 'posva/vim-vue' " Vue.js
Plugin 'mxw/vim-jsx' " JSX
Plugin 'ap/vim-css-color'

if has("nvim")
    " NVIM Only
    Plugin 'Shougo/deoplete.nvim'
else
    " VIM Only
    if has("Lua")
        Plugin 'Shougo/neocomplete.vim'
    endif
endif


filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" keep persistent_undo
if has("persistent_undo")
    silent call system('mkdir -p ~/.vimundo')
    set undodir=~/.vimundo/
    set undofile
endif

" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" Remember info about open buffers on close
set viminfo^=%

set timeoutlen=1000 ttimeoutlen=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme/Colors                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable 256-color mode.
set t_Co=256

if isdirectory(expand("~/.vim/bundle/papercolor-theme/colors"))
    set background=dark
    let g:airline_theme = "papercolor"
    colorscheme PaperColor
endif

" The point at which we can have full colors :D
if has("patch-7.4-1799") && isdirectory(expand("~/.vim/bundle/vim-srcery-drk"))
    set termguicolors
    set background=dark
    let g:enable_bold_font = 1
    let g:airline_theme = "hybrid"
    colorscheme srcery-drk
endif

" enable syntax highlighting (previously syntax on).
syntax enable

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
set foldmethod=manual     " vim is slow to compute folds
set scrolloff=5           " keep minimal number of lines above/below cursor
set showcmd               " show command line at bottom of screen
set sidescroll=3          " scroll sideways 3 characters at a time
set cc=110                " ruler at line 110


" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map seems to be nicer than mapleader
map <Space> <Leader>

" move lines of text up/down and change indent with C-j/k/h/l
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-l> >>
nnoremap <C-h> <<

" Normal mode gets Shift+J/K and < > to move things around as well
nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
nnoremap < <<
nnoremap > >>

inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
inoremap <C-l> <Esc>>>i
inoremap <C-h> <Esc><<i

vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <C-l> >gv
vnoremap <C-h> <gv

" Make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" select last pasted text
nnoremap gp `[v`]


" Faster save methods
" :w, q, q!, x remaps
"""""""""""""""""""""

" Enter saves
nnoremap <Enter> :w<CR>

" Shift W, X, Q and !
nnoremap W :w<CR>
nnoremap X :x<CR>
nnoremap Q :q<CR>
nnoremap ! :q!<CR>

" I do :W all the time...
command -nargs=* W w

" Allow moving through wrapped lines one at a time
nnoremap j gj
nnoremap k gk

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null % <cr>

" faster pane switching
nnoremap <C-w> <C-w><C-w>

" q: typo
nnoremap q: :q

" move to end of line with <Leader> H & L
nnoremap <Leader>h 0
nnoremap <Leader>l $

" NERDCommentToggle, can't be nore for some reason
nmap <Leader>, <Plug>NERDCommenterToggle
vmap <Leader>, <Plug>NERDCommenterToggle

nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle

vnoremap <C-c> :w !pbcopy<CR><CR>

" Faster :
nnoremap <Leader>; <Esc>:
vnoremap <Leader>; <Esc>:

" Fast replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Grep for the current word in the working dir
nnoremap <silent> <C-g> :Ggrep <cword><CR>

" Remove trailing whitespaces with <Leader><BS> or :Whitespace
nnoremap <silent> <Leader><BS> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:w<CR>
command -nargs=* Whitespace :%s/\s\+$

" Fix file to use spaces instead of tabs
command -nargs=* Fixtab :set tabstop=4 softtabstop=4 expandtab <bar> retab <bar> Whitespace

" JSON pretty
command -nargs=* JSON %!python -m json.tool

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"


" Function key maps
"""""""""""""""""""

" F1: spellcheck
noremap <silent> <F1> :setlocal spell!<CR>

" F2: quick rename (like file renaming for Windows)
nnoremap <F2> ciw
vnoremap <F2> c

" F3: NERDTree
noremap <silent> <F3> :NERDTreeToggle<CR>

" F4: UndoTree
noremap <silent> <F4> :UndotreeToggle<CR>

" F6: paste mode
set pastetoggle=<F6>
nnoremap <F6> :set paste<CR>o

" F7: Set numbers (easier copy)
noremap <silent> <F7> :set nu!<CR> :GitGutterToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap                         " do not wrap text
set expandtab                      " insert tabs as spaces
set shiftwidth=4                   " number of spaces for auto indent and line shift
set softtabstop=4                  " number of spaces pressing <Tab> counts for
set tabstop=4                      " number of spaces a <Tab> in the file counts for
set autoindent                     " auto indent things
set cindent                        " syntax-aware auto indent
set smarttab                       " <BS> deletes a shiftwidth worth of space
set linebreak                      " break on whitespace, not words
set encoding=utf-8                 " default text mode
set fileformat=unix                " dos is kill
set showbreak=↪\                   " show when line wraps

" preserve indentation on wrap
if v:version >= 704
    set breakindent
endif

" Highlight trailing whitespace, tabs and nbsp
set list
set listchars=tab:\|·,trail:·,nbsp:+

" Use tabs for go,makefiles
autocmd FileType go,make
    \ setlocal noexpandtab |
    \ setlocal listchars=tab:\ \ ,trail:·,nbsp:+

" Set OS X clipboard and vim as the same
"set clipboard=unnamed

" Options for specific file types:
""""""""""""""""""""""""""""""""""

" Enable Spell Checking for markdown files
autocmd FileType, markdown
    \ setlocal spell

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" Map <Leader>r to compule and run rust code
autocmd Filetype rust nnoremap <Leader>r :w <bar> !clear && rustc % && (tput setaf 2; echo "\nCompiled Successfully\!\n")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prefix plugin configs with a if statement like:
" if isdirectory(expand("~/.vim/bundle/plugin-dir"))
" This will then make sure to not set things that don't exist

if isdirectory(expand("~/.vim/bundle/vim-easy-align"))
    nnoremap <Leader>a <Plug>(EasyAlign)
endif

if isdirectory(expand("~/.vim/bundle/nerdtree"))
    nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
    " Hide some files
    let NERDTreeIgnore = ['\.pyc$'] " Hide pyc files
endif

if isdirectory(expand("~/.vim/bundle/vim-surround"))
    autocmd FileType php let b:surround_63 = "<?php \r ?>"
endif

if isdirectory(expand("~/.vim/bundle/vim-airline"))
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    let g:airline#extensions#whitespace#enabled = 0
    " Don't show the git branch (takes up too much room)
    let g:airline_section_b = '%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}'
    " Don't show current tag (Ehh, don't need)
    let g:airline_section_x = '%{airline#util#wrap(airline#parts#filetype(),0)}'
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

"if isdirectory(expand("~/.vim/bundle/neocomplete.vim"))
    "if has("Lua")
        "let g:neocomplete#enable_at_startup = 1
        "let g:neocomplete#enable_smart_case = 1
    "endif
"endif

if isdirectory(expand("~/.vim/bundle/ctrlp.vim"))
    "let g:ctrlp_map = 'D'
    let g:ctrlp_prompt_mappings = {
        \ 'AcceptSelection("e")': ['<c-v>', '<2-LeftMouse>'],
        \ 'AcceptSelection("v")': ['<cr>', '<RightMouse>'],
    \ }
endif

if isdirectory(expand("~/.vim/bundle/deoplete.nvim"))
    let g:deoplete#enable_at_startup = 1
endif

if isdirectory(expand("~/.vim/bundle/vim-jsx"))
    let g:jsx_ext_required = 0
endif

if isdirectory(expand("~/.vim/bundle/vim-indent-guides"))
    nmap <silent><unique> <Leader>i <Plug>IndentGuidesToggle
    let g:indent_guides_guide_size = 1
endif

if isdirectory(expand("~/.vim/bundle/vim-textobj-user"))
    " Select a Text Object that is surrounded by whitespace
    " use a<Space> and i<Space>. All normal things should work
    " like ci<Space>, vi<Space>, di<Space>.. etc
    call textobj#user#plugin('textinwhitespace', {
    \   '-': {
    \       'select-a-function': 'TextInWhitespaceA',
    \       'select-a': 'a<Space>',
    \       'select-i-function': 'TextInWhitespaceI',
    \       'select-i': 'i<Space>',
    \   },
    \ })

    " Select object, with surrounding whitespace
    function! TextInWhitespaceA()
        " Search for a whitespace char backwards on current line only
        let s = search('\s', 'b', line('.'))

        " If not found, (ie a word with no indent) use ^ and
        " go to beginning of line
        if s == 0
            normal! ^
        endif

        " Save the current cursor position for the start
        let head_pos = getpos('.')

        " Find the next whitespace char
        let s = search('\s', '', line('.'))

        " If no whitespace on current line, (ie no trailing whitespace for
        " last word), use $ to go to end of line
        if s == 0
            normal! $
        endif

        " Save the current cursor position for the end
        let tail_pos = getpos('.')

        return ['v', head_pos, tail_pos]
    endfunction

    " Select object, without surrounding whitespace
    function! TextInWhitespaceI()
        " Search for a whitespace char backwards on current line only
        let s = search('\s', 'b', line('.'))

        " If not found, (ie a word with no indent) use ^ and
        " go to beginning of line
        if s == 0
            normal! ^
            let head_pos = getpos('.')
        else
            " For other cases where it did find it, get the pos, but add 1 to
            " the column so that it doesn't select the whitespace char it found
            let head_pos = getpos('.')
            let head_pos[2] = head_pos[2] + 1
        endif

        " Find the next whitespace char
        let s = search('\s', '', line('.'))
        " If no whitespace on current line, (ie no trailing whitespace for
        " last word), use $ to go to end of line
        if s == 0
            normal! $
            let tail_pos = getpos('.')
        else
            " For other cases where it did find it, get the pos, but subtract 1 to
            " the column so that it doesn't select the whitespace char it found
            let tail_pos = getpos('.')
            let tail_pos[2] = tail_pos[2] - 1
        endif

        return ['v', head_pos, tail_pos]
    endfunction
endif
