""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filename: .vimrc                                                           "
"                                                                            "
" Sections:                                                                  "
"   Vundle .................. Setup Vundle at start                          "
"   General ................. General Vim behavior                           "
"   Theme/Colors ............ Colors, fonts, etc.                            "
"   Vim UI .................. User interface behavior                        "
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

Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'nanotech/jellybeans.vim'
Plugin 'mattn/emmet-vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'

if has("Lua")
  Plugin     'Shougo/neocomplete.vim'
endif

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" get rid of Vi compatibility mode.
set nocompatible

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

let mapleader = "\<Space>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme/Colors                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).

if isdirectory(expand("~/.vim/bundle/jellybeans.vim"))
  colorscheme jellybeans
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

set splitbelow            " Split (sp) below
set splitright            " Split (vsp) to the right

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Map C - Nav Keys to move between splits
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

" remaps
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>1 :q!<CR>
nmap <Leader>x :wq<CR>
nmap <Leader>l <C-w><C-w>

nmap <Leader>j <C-d>
nmap <Leader>k <C-u>

nmap H 0
nmap L $

" Remove trailing whitespaces
nmap <silent> <Leader><BS> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:w<CR>

" <TAB>: completion.
imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

imap <C-j> <ESC>

map q: :q
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap                  " do not wrap text
set scrolloff=3             " keep minimal number of lines above/below cursor
set showcmd                 " show command line at bottom of screen
set sidescroll=3            " scroll sideways 3 characters at a time

set backspace=2             " make backspace behave normally
set expandtab               " insem tabs as spaces
set shiftwidth=2            " number of spaces for auto indent and line shift
set cindent                 " syntax-aware auto indent
set smarttab                " <BS> deletes a shiftwidth worth of space
set softtabstop=2           " number of spaces pressing <Tab> counts for
set tabstop=2               " number of spaces a <Tab> in the file counts for

set encoding=utf-8          " defualt text mode

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
  nmap <Leader>a <Plug>(EasyAlign)
endif

if isdirectory(expand("~/.vim/bundle/nerdtree"))
  nmap <Leader>n :NERDTreeToggle<CR>
endif

if isdirectory(expand("~/.vim/bundle/vim-airline"))
  let g:airline_theme='luna'
  let g:airline_left_sep=''
  let g:airline_right_sep=''
  let g:airline#extensions#whitespace#enabled = 0
endif

if isdirectory(expand("~/.vim/bundle/syntastic"))
  let g:syntastic_check_on_wq=0
  nmap <Leader>c :SyntasticCheck<CR>
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

if isdirectory(expand("~/.vim/bundle/emmet-vim"))
    let g:user_emmet_leader_key='<C-d>'
endif
