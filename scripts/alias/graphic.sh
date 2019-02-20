
convert_webm_to_gif () {
    local in="${1:?First arg must be a webm file path}"
    local out="${2:-output.gif}"
    echo ">>> Converting webm to gif"
    set -x
    ffmpeg -i $in -pix_fmt rgb24 $out
    set +x
}
