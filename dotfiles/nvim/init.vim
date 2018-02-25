set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
"git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
"" ______________ tomas zahradnik

" folding
Plugin 'tmhedberg/SimpylFold'
":help foldc

" Auto-Indentation
Plugin 'vim-scripts/indentpython.vim'

" Auto-Complete
Plugin 'Valloric/YouCompleteMe'
let g:ycm_python_binary_path = '/home/dd/venvs/autobaggage-n5OyURQX/bin'

" Syntax checkers
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'

" File Browsing
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'

" GitHub
Plugin 'tpope/vim-fugitive'


"" ______________ mine
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"

"%%%%%%%%%%%%%%%%%%%%%%%
set nocompatible "pøepne Vi do vim
"source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"set guifont=Consolas:h9:cDEFAULT "dobrý fonty
colorscheme wombat256mod "dobry barvy
"colorscheme slate


:map <F1> :let @@=expand('<cword>')<CR> 
:map <F2> :let @+=expand('<cword>')<CR> 
:map <F3> yiw 
:map <F4> "+yiw

" encoding to utf8
set encoding=utf-8

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
"tabstops 2014_06_17
set tabstop=4 
set expandtab
set shiftwidth=4 "shift width = tab = 4chars
set softtabstop=4


set modeline

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
"LATEX 2014_10_15
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
"set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
"set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
"filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
" 
"
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
"school
nnoremap <F12> :e ++enc=utf-8<CR>
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
" Tabulator
"set sw=4 "shift width = tab = 4chars
" size of a hard tabstop
set tabstop=4
" size of an "indent"
set shiftwidth=4
"
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set enc=utf-8
set fileencoding=utf-8
"set fileencodings=ucs-bom,utf8,prc

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
" grepping in current dir = http://vim.wikia.com/wiki/Find_in_files_within_Vim
:nnoremap gr :grep <cword> *<CR>
:nnoremap Gr :grep <cword> %:p:h/*<CR>
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
" open files in vim - tabbing = http://stackoverflow.com/questions/1445992/vim-file-navigation
:set wildmode=full
" Window movements; I do this often enough to warrant using up M-arrows on this"
nnoremap <A-Right> <C-W><Right>
nnoremap <A-Left> <C-W><Left>
nnoremap <A-Up> <C-W><Up>
nnoremap <A-Down> <C-W><Down>

" Open window below instead of above"
nnoremap <C-W>N :let sb=&sb<BAR>set sb<BAR>new<BAR>let &sb=sb<CR>

" Vertical equivalent of C-w-n and C-w-N"
nnoremap <C-w>v :vnew<CR>
nnoremap <C-w>V :let spr=&spr<BAR>set nospr<BAR>vnew<BAR>let &spr=spr<CR>

" I open new windows to warrant using up C-M-arrows on this"
"nmap <M-Up> <C-w>n
"nmap <M-Down> <C-w>N
"nmap <M-Right> <C-w>v
"nmap <M-Left> <C-w>V

" Mappings to move lines = http://vim.wikia.com/wiki/Moving_lines_up_or_down
"nnoremap <A-J> :m .+1<CR>==
"nnoremap <A-K> :m .-2<CR>==
"inoremap <A-J> <Esc>:m .+1<CR>==gi
"inoremap <A-K> <Esc>:m .-2<CR>==gi
"vnoremap <A-J> :m '>+1<CR>gv=gv
"vnoremap <A-K> :m '<-2<CR>gv=gv

" move
nnoremap <A-k> <up>
nnoremap <A-j> <down>
nnoremap <A-l> <right>
nnoremap <A-h> <left>

inoremap <A-k> <up>
inoremap <A-j> <down>
inoremap <A-l> <right>
inoremap <A-h> <left>

vnoremap <A-k> <up>
vnoremap <A-j> <down>
vnoremap <A-l> <right>
vnoremap <A-h> <left>

" panes goto
nnoremap <A-K> <C-W><up>
nnoremap <A-J> <C-W><down>
nnoremap <A-L> <C-W><right>
nnoremap <A-H> <C-W><left>

" visual with -alt
nnoremap <A-v> <C-v>

" increment
" noremap <C-I> <C-A>
" save and copy

function! SaveStm32()
    echom "Saving data to PYBFLASH"
    :w!
"    :w!/media/gr4viton/PYBFLASH/main.py
"    :cp /home/gr4viton/DEV/stm32_program/main.py /media/gr4viton/PYBFLASH/
    :!cp /home/gr4viton/DEV/microsnake/main.py /media/gr4viton/PYBFLASH/
    :!cp /home/gr4viton/DEV/microsnake/lcd_i2c.py /media/gr4viton/PYBFLASH/
    :!cp /home/gr4viton/DEV/microsnake/microsnake.py /media/gr4viton/PYBFLASH/
    :!cp /home/gr4viton/DEV/microsnake/shared_globals.py /media/gr4viton/PYBFLASH/    
endfunction
map <F5> :call SaveStm32()<CR>
"map <F5> :w!<CR>

:set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
":colorscheme slate
:syntax on
":set number
"

" Trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre *.py :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.md :call <SID>StripTrailingWhitespaces()

" automatically wrap gitcommit to 72 chars = coala ready
au FileType gitcommit set tw=72



call plug#begin()
Plug 'roxma/nvim-completion-manager'

" Multi-file search and replace
Plug 'brooth/far.vim'

" jedi-vim is a VIM binding to the autocompletion library Jedi.
Plug 'davidhalter/jedi-vim'

" syntax checker
Plug 'scrooloose/syntastic'

" code snippets plugin
Plug 'SirVer/ultisnips'

" snippets library
Plug 'honza/vim-snippets'

" status bar for vim
Plug 'vim-airline/vim-airline'

" automatic paste mode on ctrl+v
Plug 'ConradIrwin/vim-bracketed-paste'

" flake8 on F7
Plug 'nvie/vim-flake8'

" unimpared bracket shortcuts (]l for syntastic errors)
Plug 'tpope/vim-unimpaired'

" wakatime tracker - kokos - not reliable
" Plug 'wakatime/vim-wakatime'

" ZoomWin ^W o
"Plugin 'itspriddle/ZoomWin'

call plug#end()

" Auto-Indentation
"Plugin 'vim-scripts/indentpython.vim'

" Auto-Complete
"Plugin 'Valloric/YouCompleteMe'

" Syntax checkers
"Plugin 'scrooloose/syntastic'
"Plugin 'nvie/vim-flake8'

" File Browsing
"Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'kien/ctrlp.vim'

" GitHub
"Plugin 'tpope/vim-fugitive'

"" ______________ mine


" Martin-kokos setup

"" Options
syntax on
filetype plugin indent on
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set laststatus=2
set hlsearch

set pastetoggle=<F2>


""disable visual mode with mouse
"set mouse-=a

""search for visually selected text with //
vnoremap // y/<C-R>"<CR>

""search and replace hilighted text with ^R
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:syntastic_python_flake8_args='--ignore=E501,E225'


" noremap = nvo == normal + (visual + select) + operator pending
" noremap! = ic == insert + command-line mode
" alt is not functional in urxvt
" https://unix.stackexchange.com/questions/199683/alt-mappings-for-vim-in-urxvt
"
" ctags for multi-file function definition search
set tags=/srv/da/tags/tags
" :tag <tag>
" pattern
" :tag /<pattern>
noremap <A-{> :tjump /
" preview
" :ptag <tag>
" open in the same
inoremap <A-p> <C-]>
noremap <A-p> <C-]>
" show list of tag links if there is more than one link
noremap <A-P> g<C-]>
" or :tjump <tag>

inoremap <A-[> :tnext<Enter>
noremap <A-[> :tnext<Enter>
inoremap <A-o> :tprev<Enter>
noremap <A-o> :tprev<Enter>

" return to where the first tag was searched for
noremap <A-O> <C-t>


" SILVER RULE!
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>


"let zoom=":tabnew | :b#"
"noremap <C-w>o zoom
