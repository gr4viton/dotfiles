

# git
GIT_ALIAS_FILE="$HOME/.gitconfig"

git_alias_set () {
	ABBREV="${1:?abbreviation}"
	COMMAND="${2:?abbreviation}"
	git config --global alias.$ABBREV $COMMAND
}

git_alias_show () {
	cat $GIT_ALIAS_FILE
}

git_alias_open () {
	vim $GIT_ALIAS_FILE
}

conf_dev () {
	echo "S"
}


# .ssh id_rsa


# firefox

dir_firefox_rc="/home/dd/.mozilla/firefox/0h063v0s.default-release/"
firefox_config_black_load_screen () {
    # add black background to firefox loading screen
    # https://www.reddit.com/r/firefox/comments/848oej/how_can_i_change_the_colour_of_the_pagetab/

    fol="$dir_firefox_rc/chrome/"
    mkdir $fol


    fil="$dir_firefox_rc/chrome/userContent.css"
    cat <<"EOF" > $fil
@-moz-document url(about:blank) {
    html,body { background: #38383d; }
}
EOF
    echo $fil
    cat $fil

    fil="$dir_firefox_rc/chrome/userChrome.css"
    cat <<"EOF" > $fil
browser[type="content-primary"], tabbrowser tabpanels, #appcontent > #content {
  background-color: #000000 !important;
}
EOF

    echo $fil
    cat $fil
}

firefox_virc_background () {
    fil1="$dir_firefox_rc/chrome/userContent.css"
    fil2="$dir_firefox_rc/chrome/userChrome.css"
    vim -O $fil1 $fil2
}

# ==IF(
#     AND($T105<>"",$H105="D"),
#     IF(
#         $R105<DATEVALUE($T105),
#         DATEDIF($R105,DATEVALUE($T105),"D"),
#         DATEDIF(DATEVALUE($T105),$R105,"D")
#     ),
#     "."
# )

# ==IF( AND($T105<>"",$H105="D"), IF( $R105<DATEVALUE($T105), DATEDIF($R105,DATEVALUE($T105),"D"), DATEDIF(DATEVALUE($T105),$R105,"D")), ".")
