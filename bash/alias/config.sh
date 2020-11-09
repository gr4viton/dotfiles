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

