
convert_webm_to_gif_ () {
    local in="${1:?First arg must be a webm file path}"
    local out="${2:-output.gif}"
    echo ">>> Converting webm to gif"
    set -x
    ffmpeg -i $in -pix_fmt rgb24 $out
    set +x
}

convert_webp_to_png () {
    local from="webp"
    local to="png"
}

convert_via_ffmpeg () {
    local from="${1:?from-extension}"
    local to="${2:?to-extension}"
    local in="${3:?First arg must be a $from file path}"
    local out="${4:-output.$to}"
    shift; shift; shift; shift;

    echo ">>> Converting $from to $to"
    set -x
    ffmpeg -i "$in" "$out" "$@"
    set +x
}

convert_webm_to_gif () {
    convert_via_ffmpeg "webm" "gif" $1 $2 "-pix_fmt rgb24"
}

convert_webm_to_mp4 () {
    convert_via_ffmpeg "webm" "mp4" $@ ""
}

convert_webp_to_png () {
    convert_via_ffmpeg "webp" "png" $1 $2 "-pix_fmt rgb24"
}
