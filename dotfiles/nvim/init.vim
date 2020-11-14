" install plugInstall and dependencies then run vim and `:PlugInstall`

" if you get `Error detected while processing function <SNR>115_on_core_channel_error: `
" then you have to set ycm folder for saving the ctags (auto-complete)
"
" but then again i may switch to coc.vim instead of YouCompleteMe ? 

set nocompatible              " be iMproved, required
" filetype off                  " required

" Quickly edit/reload this configuration file
cabbrev vrc :vs $MYVIMRC<CR>
" cabbrev src :vsplit<Enter> :e ~/.config/nvim/init.vim<Enter> :so %<Enter> :q<Enter>
cabbrev srcc :so $MYVIMRC<CR>

"" ______________ tomas zahradnik

" undo tree - not working?
"Plugin 'sjl/gundo'


"" ______________ mine
" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on


"%%%%%%%%%%%%%%%%%%%%%%%
set nocompatible "pøepne Vi do vim
"source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

if !exists("*MyDiff")
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
endif
" cabbrev diffexpr=MyDiff()

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

" function! SaveStm32()
function! SaveEspUsb()
    " echom "Saving data to PYBFLASH"
    echom "rsync data to esp"
    :w!
"    :w!/media/gr4viton/PYBFLASH/main.py
"    :cp /home/gr4viton/DEV/stm32_program/main.py /media/gr4viton/PYBFLASH/
    " :!cp /home/gr4viton/DEV/microsnake/main.py /media/gr4viton/PYBFLASH/
    " :!cp /home/gr4viton/DEV/microsnake/lcd_i2c.py /media/gr4viton/PYBFLASH/
    " :!cp /home/gr4viton/DEV/microsnake/microsnake.py /media/gr4viton/PYBFLASH/
    " :!cp /home/gr4viton/DEV/microsnake/shared_globals.py /media/gr4viton/PYBFLASH/    
    " :!esp_rsync
    :! rshell --port=/dev/ttyUSB0 rsync /srv/dd/micropython/esp8266/esp_fun/src/ /esp8/

endfunction
"rshell" esp8266 micropython "telnet"
map <F5> :call SaveEspUsb()<CR>

function! SaveEspWebrepl()
    echom "copy file to esp via webrepl"
    :! /srv/dd/micropython/esp8266/webrepl/webrepl_cli.py /srv/dd/micropython/esp8266/esp_fun/src/flash/%:t 192.168.4.1:/flash/ -p ESPESPESP
endfunction

map <F6> :call SaveEspWebrepl()<CR>

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
autocmd BufWritePre *.sh :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.md :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.yaml :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.yml :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre Dockerfile.* :call <SID>StripTrailingWhitespaces()

" turn on line wrapping
set wrap

" automatically wrap gitcommit to 72 chars = coala ready
au FileType gitcommit set tw=72
autocmd FileType yaml,yml,md setlocal ts=2 sts=2 sw=2 expandtab




" Plug - minimalistic plugin manager
" PlugStatus
" PlugDiff
" PlugInstall [name...] [#threads]

call plug#begin()

"
" coc = vscode in vim
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

""""""""""""""""""""""""" not using yet
" folding

Plug 'tmhedberg/SimpylFold'
":help foldc  = zo zc zn zN

Plug 'sjl/gundo.vim'
" vim undo tree visualise

Plug 'glacambre/firenvim', {'do': { _ -> firenvim#install(0) } }
" firefox vim plugin

Plug 'ervandew/supertab'
" insert tab hinter

Plug 'SirVer/ultisnips'
" code snippets plugin

" Plug 'roxma/nvim-completion-manager'
" completion manager

Plug 'tpope/vim-eunuch'
" Mkdir, Move, Rename, Wall, SudoWrite, SudoEdit

Plug 'tpope/vim-repeat'
" powerful `.` to repeat multiple-native commands from mapping

Plug 'tpope/vim-vinegar'
" more powerful netrw file browser

Plug 'tpope/vim-tbone'
" tmux basics

Plug 'brooth/far.vim'
" Multi-file search and replace

Plug 'tpope/vim-unimpaired'
" unimpared shortcuts (]l for syntastic errors)
" ]q :cnext, [q :cprev, ]a :next, [b :prev, ]/[<Space>
" [y ]y escaping C String style
" []f next, prev file in the directory
" []n SCM conflict markers (git rebase conflicts)

Plug 'tpope/vim-rsi'
" emacs hotkeys in commandline 
" C-a, C-w etc

" Plug 'tpope/vim-ragtag'
" enhances tpope/vim-surround

" Plug 'tpope/vim-speeddating'
" manages to increment dates correctly
" C-a + C-x (plus shift in my binding)
" to make it work only visual works = v C-a

Plug 'tpope/vim-surround'
" Change parenthesis:
" cs"' cst" cs'<q>
" ds" ds} ds)

Plug 'tpope/vim-abolish'
" syntax style transformation
" coerce to x (crs, crm)..
" s snake_case
" m MixedCase
" c camelCase
" u UPPER_CASE
" - dash-case
" . dot.case
" <space> space case
" t Title Case
" .. also :Subvert/child{,ren}/adult{,s}/g

" Plug 'tpope/vim-sleuth'
" auto indentation

" Plug 'tpope/vim-flagship'
" tab line

" Plug 'tpope/vim-airline'
" status + tabline
" Plug 'powerline/powerline'
" status + tabline

Plug 'majutsushi/tagbar'
" semantic path in bar
" show class-function in separate pane

Plug 'tpope/vim-jdaddy'
" json manipulation
" aj = outermost text object
" gqaj = prettyprint
" gwaj = insert json from clipboard

" Plug 'tpope/vim-afterimage'
" lol vim graphic editor
" png, ico, gif

" interesting:
" vim-sexp-mappings-for-regular-people
" https://github.com/tpope/git-bump

Plug 'vim-scripts/indentpython.vim'
" Auto-Indentation

" Plug 'Valloric/YouCompleteMe'
" Auto-Complete

" Plug 'davidhalter/jedi-vim'
" jedi-vim is a VIM binding to the autocompletion library Jedi.

" File Browsing

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'


"Plugin 'kien/ctrlp.vim'

Plug 'Numkil/ag.nvim'
" ag 
" silversearcher
" :Ag
" e    to open file and close the quickfix window
" o    to open (same as enter)
" go   to preview file (open but maintain focus on ag.nvim results)
" t    to open in new tab
" T    to open in new tab silently
" h    to open in horizontal split
" H    to open in horizontal split silently
" v    to open in vertical split
" gv   to open in vertical split silently
" q    to close the quickfix window

" Plug 'rking/ag.vim'  
" ag silversearcher
" ??

" git

Plug 'airblade/vim-gitgutter'
" show diffs
" - just works and shows diffs

Plug 'tpope/vim-fugitive'
" GitHub
" Gbrowse Gblame Glog Ggrep Gmove

Plug 'shumphrey/fugitive-gitlab.vim'  
" gitlab integration
" one more setting: let g:fugitive_gitlab_domains = ['https://gitlab.skypicker.com']

Plug 'tommcdo/vim-fubitive'
" bitbucket integration

Plug 'tpope/vim-rhubarb'
" github integration


""""""""""""""""""""""""" using and know

"""""""" INPUT

" automatic paste mode on ctrl+v
Plug 'ConradIrwin/vim-bracketed-paste'

"""""""" SYNTAX

Plug 'scrooloose/syntastic' 
" syntax checker _ some update
"- fuck what happened it nows does not like

Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }
" async lint syntax highlighter

Plug 'tpope/vim-commentary'
" commeng via gc<move> gcc=oneline

Plug 'tpope/vim-obsession'
" auto session saving into Session.vim
" :Obsess

"""""""" OTHER

Plug 'honza/vim-snippets'
" snippets library

" Plug 'vim-airline/vim-airline'
" status bar for vim _ for each window

Plug 'Chiel92/vim-autoformat'
" autoformat
" :afo

Plug 'wincent/command-t'
" wincent/command-t
" c-T for file navigation
" set different command!
" not used yet
" 'git://git.wincent.com/command-t.git'

Plug 'ctrlpvim/ctrlp.vim'
" ^P for fille open
" GOOD using


""""""""""""""""""""""""" will not use
" black formatter _ instead use vim-autoformat
"Plug 'ambv/black'
" flake8 on F7
"Plug 'nvie/vim-flake8'
" wakatime tracker - kokos - not reliable
"Plug 'wakatime/vim-wakatime'
" ZoomWin ^W o
"Plug 'itspriddle/ZoomWin'
"

"focus gained - makes it working in vim terminal
" https://tmuxcheatsheet.com/tmux-plugins-tools/?full_name=tmux-plugins%2Fvim-tmux-focus-events
" copies tmux-copy register to vim unnamed register `"`
Plug 'tmux-plugins/vim-tmux-focus-events'

call plug#end()

"" ______________ mine
" coerce does not work at all 2020-04-26
nmap cr  <Plug>Coerce
nmap gcr <Plug>Coerce

"nnoremap <F6> :GundoToggle<CR>

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


"" visual mode with mouse - allows selecting via mouse in one pane only
" https://unix.stackexchange.com/a/50735
if !has('nvim')
  set ttymouse=xterm2
endif
set mouse+=a

""search for visually selected text with //
vnoremap // y/<C-R>"<CR>

""search and replace hilighted text with ^R
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>


" noremap = nvo == normal + (visual + select) + operator pending
" noremap! = ic == insert + command-line mode
" alt is not functional in urxvt
" https://unix.stackexchange.com/questions/199683/alt-mappings-for-vim-in-urxvt


""" ctags
" ctags for multi-file function definition search
set tags=/srv/kiwi/data/tags/tags
" install https://robhoward.id.au/blog/2012/03/ctags-with-vim/
" in crontab add `ctags -R

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

" moving through tags
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

" tabs control
noremap <A-z> :tabedit %<Enter>
noremap <A-Z> :tabclose <Enter>

noremap <A-I> :tabn<Enter>
noremap <A-U> :tabp<Enter>



" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

"""""""""""""""""" PLUGINS

""" Chiel92/vim-autoformat
cabbrev afo :Autoformat
let g:formatdef_black_120s = '"black -q -S -l 120 ".(&textwidth ? "-l".&textwidth : "")." -"'
let g:formatdef_black_120 = '"black -q -l 120 ".(&textwidth ? "-l".&textwidth : "")." -"'
let g:formatters_python = ['black_120s']

com! Jsnp %!python -m json.tool
com! Jsn %!jq .

""" ycm
" let g:ycm_python_binary_path = '/home/dd/venvs/autobaggage-n5OyURQX/bin' " not sure if this is correct

" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'

""" scrooloose/syntastic
let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:syntastic_python_flake8_args='--ignore=E501,E225'
let g:syntastic_quiet_messages = { "regex": 'missing-docstring\|no-member\|too-many-instance-attributes\|import-error\|unused-argument\|protected-access\|no-name-in-module\|too-few-public-methods\|unsubscriptable-object' }

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_python_checkers = ['pylint']

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

"""""""" # outdated
" # plug amv/black
" :Black :BlackUpgrade :BlackVersion
" let g:black_skip_string_normalization=1
" let g:black_linelength=120
"

" infinite undo in files even across vim sessions
set undofile
set undodir=~/.vim/undodir

" xmllint external prog for xml pretty formatting - use gg=G
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
"set xml_format="xmllint --format -"
cabbrev xml_format :xmllint --format -

" set pwd
" globally
cabbrev cd_pwd :cd %:p:h
" only to this window
cabbrev cd_pwd_win :lcd %:p:h

"http://vim.wikia.com/wiki/Get_the_name_of_the_current_file
cabbrev pwd_relative :echo @%
cabbrev pwd_file :echo expand('%:p')
cabbrev pwd_path :echo expand('%:p:h')


" Autoreload on src save
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd


" YouCompleteMe and UltiSnips compatibility, with the helper of supertab
" (via http://stackoverflow.com/a/22253548/1626737)
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
" let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

let g:UltiSnipsListSnippets            = '<c-s-tab>'

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"
let g:UltiSnipsSnippetsDirectories = ["snips", "UltiSnips"]

cabbrev Ue :UltiSnipsEdit

function! UltiSnipsVimSnippetsOpen(name)
    echom "Openning vim-snippets for:"
    echom a:name
    let vim_snip_path = "~/.config/nvim/plugged/vim-snippets/UltiSnips/" . a:name . ".snippets"
    echo vim_snip_path
    execute 'vs' vim_snip_path
    "vs a:vim_snip_path
endfunction

cabbrev Uve :call UltiSnipsVimSnippetsOpen("
cabbrev Uvepy :call UltiSnipsVimSnippetsOpen("python")

" vim-snippets plug ultisnips are here:
" ~/.config/nvim/plugged/vim-snippets/UltiSnips/python.snippets
"
" open unfolded
set nofoldenable


" fugitive gitlab
let g:fugitive_gitlab_domains = ['https://gitlab.skypicker.com']
" disable statusline git branch name
let g:flagship_skip = 'fugitive#statusline\|FugitiveStatusline'

cabbrev Gb Gbrowse
cabbrev Gbl Gblame

cabbrev mux Tmux

" vim-flagship + vim-airline
" 
set laststatus=2 
" always show tabline
set showtabline=2
" enable global shortcuts
set guioptions-=e

" https://marcorucci.tumblr.com/
" https://stackoverflow.com/questions/1497958/how-do-i-use-vim-registers#
vnoremap p "_dP
" noremap x "_x  " i do not want this as then `xp` does not work for swiching chars


" Open markdown files with Chrome.
autocmd BufEnter *.md exe 'noremap <F6> :! chromium-browser %:p<CR>'

" Semshi highlights
" :Semshi <cmd>
" cmds: enable disable, toggle pause highlight clear rename error goto error
" goto
" https://github.com/numirias/semshi#highlights
" 
function! MyCustomHighlights()
    hi semshiSelected      ctermfg=231 guifg=#ffffff ctermbg=DarkGray guibg=#d7005f

endfunction
autocmd FileType python call MyCustomHighlights()

" py files f-string not syntax error any more
let g:pymode_python = 'python3'

" how could have i live without this!
" zc zo
let g:foldmethod = "indent"

nmap <F8> :TagbarToggle<CR>

" esc delay
set timeoutlen=1000 ttimeoutlen=0

















""""""""""""""""""""""""""""""""""""""""""""""""
"" coc
""
"" # plugins
"" :CocInstall coc-python
""
"" if hidden is not set, TextEdit might fail.
"set hidden

"" Some servers have issues with backup files, see #649
"set nobackup
"set nowritebackup

"" Better display for messages
"set cmdheight=2

"" You will have bad experience for diagnostic messages when it's default 4000.
"set updatetime=300

"" don't give |ins-completion-menu| messages.
"set shortmess+=c

"" always show signcolumns
"set signcolumn=yes

"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"" inoremap <silent><expr> <TAB>
""       \ pumvisible() ? "\<C-n>" :
""       \ <SID>check_back_space() ? "\<TAB>" :
""       \ coc#refresh()
"" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" Or use `complete_info` if your vim support it, like:
"" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

"" Use `[g` and `]g` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction

"" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)

"" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)

"" Create mappings for function text object, requires document symbols feature of languageserver.
"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)

"" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"" nmap <silent> <C-d> <Plug>(coc-range-select)
"" xmap <silent> <C-d> <Plug>(coc-range-select)

"" Use `:Format` to format current buffer
"command! -nargs=0 Format :call CocAction('format')

"" Use `:Fold` to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" use `:OR` for organize import of current buffer
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Add status line support, for integration with other plugin, checkout `:h coc-status`
"" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Using CocList
"" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"
"


