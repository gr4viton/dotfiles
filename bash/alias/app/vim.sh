# application: vim nvim

# alias vircvim_old='vim '$home'.vimrc'
alias vircvim='vim ~/.config/nvim/init.vim'

alias vircbash="vim $rcbash"

vimopen () {
    nvim -O "$@"
}

vimo () {
    if [ "$#" -lt 10 ]; then
        vimopen "$@"
    else
        if $(ask_yes "$# files to be open, continue?"); then
            vimopen "$@"
        else
            echo "skipped opening of $# files"
        fi
    fi
}

vim_last_learned () {
    out=$(cat <<-EOF
%s//.../g  # uses the last searched term
^r" # yells buffer to commandline
EOF
)
    echo "$out"
}

vim () {
    nvim -O "$@"
}

vis () {
    # load vim Session file
    nvim -S "$@"
}

viss () {
    vis Session.vim
}

vimdiff_color () {
    vim -d $1 $2 +"windo set wrap"
}

# alias vimo='vim -O'

alias vim_is_clipboardable='vim --version | grep clipboard' #` gets you `-xterm_clipboard'

viag() {
    # search via ag and open the found files - search for the string in the opened files
    vimo -c "silent! /$@" $(ag -l "$@")
}

viagp() {
    # search via ag --py and open the found files - search for the string in the opened files
    vimo -c "silent! /$@" $(agp -l "$@")
}

visearch() {
    # open file specified and search in it the first arg
    search_pattern=$1
    shift  # remove $1 from $@
    vimo -c "silent! /$search_pattern" $@
}

viag_cd () {
    dir=$1
    shift
    cd $dir
    viag $@ $dir
}

viag_gitlabci_in_subfolders () {
    # have to have "/.git/" line in ~/.agignore
    REGEX="${1?regex for files}"
    viag $REGEX --hidden -G ".*/.*gitlab-ci.y.*ml" -l
}


