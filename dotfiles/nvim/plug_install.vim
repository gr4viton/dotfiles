" File with only plug installs
" I am using plug-vim plugin package manager

" Plug - minimalistic plugin manager
" PlugStatus
" PlugDiff
" PlugInstall [name...] [#threads]

" if !HostnameIs('dell')
" elseif !HostnameIs('rosbot')
" endif

call plug#begin()

Plug 'Chiel92/vim-autoformat'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'Numkil/ag.nvim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'brooth/far.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'glacambre/firenvim', {'do': { _ -> firenvim#install(0) } }
Plug 'honza/vim-snippets'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic' 
Plug 'shumphrey/fugitive-gitlab.vim'  
Plug 'sjl/gundo.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/indentpython.vim'
Plug 'wincent/command-t'

Plug 'gabrielelana/vim-markdown'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'

" Plug 'Valloric/YouCompleteMe'
" Plug 'ambv/black'
" Plug 'davidhalter/jedi-vim'
" Plug 'itspriddle/ZoomWin'
" Plug 'kien/ctrlp.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'nvie/vim-flake8'
" Plug 'powerline/powerline'
" Plug 'rking/ag.vim'  
" Plug 'roxma/nvim-completion-manager'
" Plug 'tpope/vim-afterimage'
" Plug 'tpope/vim-airline'
" Plug 'tpope/vim-flagship'
" Plug 'tpope/vim-ragtag'
" Plug 'tpope/vim-sleuth'
" Plug 'tpope/vim-speeddating'
" Plug 'vim-airline/vim-airline'
" Plug 'wakatime/vim-wakatime'

call plug#end()
