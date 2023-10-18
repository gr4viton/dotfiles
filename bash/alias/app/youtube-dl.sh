# __youtube-dl__ __ydl__
# alias youtube-dl="/srv/dd/app/youtube-dl/bin/youtube-dl"

dirydlb="$HOME/DATA/DNz/batch.txt"

alias ydl="youtube-dl"

ydlb () {
    youtube-dl -a $dirydlb "$@"
}

YDL_DOWNLOAD="/home/dd/DATA/youtube-dl/"

ydl_audio () {
    youtube-dl -x --audio-format mp3 -o "$YDL_DOWNLOAD/%(title)s.%(ext)s" "$@"
}

ydl_audio_playlist_youtube () {
    # 251 = mp3
    youtube-dl -f 251 -o "$YDL_DOWNLOAD/%(title)s.%(ext)s" "$@"
}

ydl_audio_playlist () {
    # does not work 2021-12-26
    youtube-dl --extract-audio --audio-format mp3 -o "$YDL_DOWNLOAD/%(title)s.%(ext)s" "$@"
}


ydlbb () {
    cd $(dirname $dirydlb)
    cd ydlbb
    set -x
    # ydl --username $YDL_USER --password $YDL_PWD $@
    ydl "$@"
    set +x
}

alias yyy="ydlbb"

alias cdydlb="cd $HOME/DATA/DNz/"
alias viydlb="vim $dirydlb $dirydlb.old"

ydl_upgrade () {
    pip3 install --upgrade youtube-dl
}

ydl_vid () {
    youtube-dl --format mp4 -o "$YDL_DOWNLOAD/%(playlist_index)s-%(title)s by %(uploader)s on %(upload_date)s in %(playlist)s.%(ext)s" "$@"
}
