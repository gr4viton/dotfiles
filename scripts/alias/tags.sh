
tags_info () {
    echo "run 'muxl tags'" to open all tags settings"
    echo "run tags_rerun to rerun
}

CTAGS_SCAN_DIR="/srv/kw"
CTAGS_TAGS_FILE="/srv/kiwi/data/tags/tags"
# CTAGS_OPTIONS_FILE="/home/dd/.config/.ctags.txt"  # old
CTAGS_OPTIONS_FILE="/home/dd/.config/ctags/default.ctags"

ctags() {
    # hide warning 2020-08-24
    # viz https://github.com/universal-ctags/ctags/issues/900#issuecomment-600097632
    command ctags "$@" 2> >(
        grep -Ev "^ctags: Warning: ignoring null tag in .+\.js\(line: .+\)$"
    )
}

tags_rerun () {
    ctags -Re -o $CTAGS_TAGS_FILE $CTAGS_SCAN_DIR --options=$CTAGS_OPTIONS_FILE --output-format=e-ctags
}


