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

" :set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
":colorscheme slate
:syntax on
":set number
"


" turn on line wrapping
set wrap

function! HostnameIs(hostname)
    " matches hostname with passed string
    return match(system("echo -n $HOST"), a:hostname) >= 0
endfunction

" load plug_install.vim, searching it in "all vim places"
runtime plug_install.vim

"" ______________ mine
" coerce does not work at all 2020-04-26
nmap cr  <Plug>Coerce
nmap gcr <Plug>Coerce

"nnoremap <F6> :GundoToggle<CR>

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
let g:formatdef_black_79 = '"black -q -l 79 ".(&textwidth ? "-l".&textwidth : "")." -"'
let g:formatters_python = ['black_120s']
let g:formatters_python = ['black_79']

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
" automatically wrap gitcommit to 72 chars = coala ready
au FileType gitcommit set tw=72

autocmd FileType yaml,yml,md,markdown setlocal ts=2 sts=2 sw=2 expandtab

""""""""""""""""""""""""

" typescript syntax highlighting
" for expo development

" dark red
hi tsxTagName guifg=#E06C75
hi tsxComponentName guifg=#E06C75
hi tsxCloseComponentName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic

" set filetypes as typescriptreact
" autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript

augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript
augroup END
""""""""""""""""""""""""

" load plug_coc.vim, searching it in "all vim places"
" runtime plug_coc.vim






