# alias youtube-dl="/srv/dd/app/youtube-dl/bin/youtube-dl"

dirydlb="$HOME/DATA/DNz/batch.txt"

alias ydl="youtube-dl"

ydlb () {
    youtube-dl -a $dirydlb $@
}

ydlbb () {
    cd $(dirname $dirydlb)
    cd ydlbb
    set -x
    # ydl --username $YDL_USER --password $YDL_PWD $@
    ydl $@
    set +x
}

alias yyy="ydlbb"

alias cdydlb="cd $HOME/DATA/DNz/"
alias viydlb="vim $dirydlb $dirydlb.old"

ydl_upgrade () {
    pip3 install --upgrade youtube-dl
}
