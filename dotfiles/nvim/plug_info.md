### Plug 'neoclide/coc.nvim', {'branch': 'release'}
coc = vscode in vim


# Not using yet

## folding

### Plug 'tmhedberg/SimpylFold'
:help foldc  = zo zc zn zN

### Plug 'sjl/gundo.vim'
vim undo tree visualise

### Plug 'ervandew/supertab'
insert tab hinter

### Plug 'SirVer/ultisnips'
code snippets plugin

### NOT Plug 'roxma/nvim-completion-manager'
completion manager

### Plug 'tpope/vim-eunuch'
Mkdir, Move, Rename, Wall, SudoWrite, SudoEdit

### Plug 'tpope/vim-repeat'
powerful `.` to repeat multiple-native commands from mapping

### Plug 'tpope/vim-vinegar'
more powerful netrw file browser

### Plug 'tpope/vim-tbone'
tmux basics

### Plug 'brooth/far.vim'
Multi-file search and replace

### Plug 'tpope/vim-unimpaired'
unimpared shortcuts (]l for syntastic errors)
]q :cnext, [q :cprev, ]a :next, [b :prev, ]/[<Space>
[y ]y escaping C String style
[]f next, prev file in the directory
[]n SCM conflict markers (git rebase conflicts)

### Plug 'tpope/vim-rsi'
emacs hotkeys in commandline
C-a, C-w etc

### NOT Plug 'tpope/vim-ragtag'
enhances tpope/vim-surround

### NOT Plug 'tpope/vim-speeddating'
manages to increment dates correctly
C-a + C-x (plus shift in my binding)
to make it work only visual works = v C-a

### Plug 'tpope/vim-surround'
Change parenthesis:
cs"' cstcs'<q>
dsds} ds)

### Plug 'tpope/vim-abolish'
syntax style transformation
coerce to x (crs, crm)..
s snake_case
m MixedCase
c camelCase
u UPPER_CASE
- dash-case
. dot.case
<space> space case
t Title Case
.. also :Subvert/child{,ren}/adult{,s}/g

### NOT Plug 'tpope/vim-sleuth'
auto indentation

### NOT Plug 'tpope/vim-flagship'
tab line

### NOT Plug 'tpope/vim-airline'
status + tabline
### NOT Plug 'powerline/powerline'
status + tabline

### Plug 'majutsushi/tagbar'
semantic path in bar
show class-function in separate pane

### Plug 'tpope/vim-jdaddy'
json manipulation
aj = outermost text object
gqaj = prettyprint
gwaj = insert json from clipboard

### NOT Plug 'tpope/vim-afterimage'
lol vim graphic editor
png, ico, gif

interesting:
vim-sexp-mappings-for-regular-people
https://github.com/tpope/git-bump

### Plug 'vim-scripts/indentpython.vim'
Auto-Indentation

### NOT Plug 'Valloric/YouCompleteMe'
Auto-Complete

### NOT Plug 'davidhalter/jedi-vim'
jedi-vim is a VIM binding to the autocompletion library Jedi.

File Browsing

### Plug 'scrooloose/nerdtree'
### Plug 'jistr/vim-nerdtree-tabs'


### NOT Plugin 'kien/ctrlp.vim'

### Plug 'Numkil/ag.nvim'
ag
silversearcher
:Ag
e    to open file and close the quickfix window
o    to open (same as enter)
go   to preview file (open but maintain focus on ag.nvim results)
t    to open in new tab
T    to open in new tab silently
h    to open in horizontal split
H    to open in horizontal split silently
v    to open in vertical split
gv   to open in vertical split silently
q    to close the quickfix window

### NOT Plug 'rking/ag.vim'
ag silversearcher
??

git

### Plug 'airblade/vim-gitgutter'
show diffs
- just works and shows diffs

### Plug 'tpope/vim-fugitive'
GitHub
Gbrowse Gblame Glog Ggrep Gmove

### Plug 'shumphrey/fugitive-gitlab.vim'
gitlab integration
one more setting: let g:fugitive_gitlab_domains = ['https://gitlab.skypicker.com']

### Plug 'tommcdo/vim-fubitive'
bitbucket integration

### Plug 'tpope/vim-rhubarb'
github integration


#  using and know

##  INPUT

automatic paste mode on ctrl+v
### Plug 'ConradIrwin/vim-bracketed-paste'

##  SYNTAX

### Plug 'scrooloose/syntastic'
syntax checker _ some update
- fuck what happened it nows does not like

### Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }
async lint syntax highlighter

### Plug 'tpope/vim-commentary'
commeng via gc<move> gcc=oneline

### Plug 'tpope/vim-obsession'
auto session saving into Session.vim
:Obsess

##  OTHER

### Plug 'honza/vim-snippets'
snippets library

### NOT Plug 'vim-airline/vim-airline'
status bar for vim _ for each window

### Plug 'Chiel92/vim-autoformat'
autoformat
:afo

### Plug 'wincent/command-t'
wincent/command-t
c-T for file navigation
set different command!
not used yet
'git://git.wincent.com/command-t.git'

### Plug 'ctrlpvim/ctrlp.vim'
^P for fille open
GOOD using


# Will not use

### NOT Plug 'ambv/black'
black formatter _ instead use vim-autoformat

### NOT Plug 'nvie/vim-flake8'
flake8 on F7

### NOT Plug 'wakatime/vim-wakatime'
wakatime tracker - kokos - not reliable

### NOT Plug 'itspriddle/ZoomWin'
ZoomWin ^W o

### Plug 'tmux-plugins/vim-tmux-focus-events'
focus gained - makes it working in vim terminal
https://tmuxcheatsheet.com/tmux-plugins-tools/?full_name=tmux-plugins%2Fvim-tmux-focus-events
copies tmux-copy register to vim unnamed register `"`

# Integrations
## firefox

### Plug 'glacambre/firenvim', {'do': { _ -> firenvim#install(0) } }
firefox vim plugin



