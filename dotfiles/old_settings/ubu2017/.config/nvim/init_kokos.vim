
call plug#begin()

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

" wakatime tracker
Plug 'wakatime/vim-wakatime'


call plug#end()


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
set mouse-=a

""search for visually selected text with //
vnoremap // y/<C-R>"<CR>

""search and replace hilighted text with ^R
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:syntastic_python_flake8_args='--ignore=E501,E225'
