
aosd_cat_install () {
    sudo apt-get install -y aosd-cat
}

aosd_get_centers_xy_args () {
    # returns the aosd_cat arguments for centers of connected screens
    # example output for 3 connected monitors

    # --xpos=2160 --ypos=1815
    # --xpos=2160 --ypos=669
    # --xpos=600 --ypos=960


    PYSRC=$(cat <<EOF
import click

@click.command()
@click.argument("resolutions", nargs=-1)  # multiple args can be passed
def main(resolutions):
    """Get the args for aosd_cat method with the xpos and ypos in centers of every connected display.

    Args:
        resoltions (str): multiline str containing the connected displays data
    """

    centers = get_centers(resolutions)
    print_aosd_cat_args(centers)

def print_aosd_cat_args(centers):
    for center in centers:
        print(f"--x-offset={center[0]} --y-offset={center[1]}")

def get_centers(resolutions):
    """Get the centers of the screens.  In the end not exactly!

    Args:
        resoltions (list of str): list of connected display screen info
            "{width}x{height}+{offset_y}+{offset_y}"  # there can be plus or minus
    """
    centers = []
    for res in resolutions:
        words = []
        for words_x in res.split("x"):
            for words_plus in words_x.split("+"):
                for word in words_plus.split("-"):
                    words.append(word)
        nums = [int(word) for word in words]
        w, h, ox, oy = nums  # width height offset_x offset_y

        # CHANGE
        center_point = (int(ox + w/8), -1 * int(oy + h/4))
        # center_point = (int(ox), -int(oy))
        # center_point = (int(ox), -int(oy))
        centers.append(center_point)
    return centers

main()
EOF
)
    echo_py_src "$PYSRC" $(display_show_data)
}

aosd_show_time () {
    # show the current time in the middle of all connected screens
    # example
    # date +"%H:%M" | aosd_cat --font="Ubuntu 48" --shadow-offset=1 --back-color=black --back-opacity=200 --position=4 --padding=32 --fore-color=white --lines=0 --fade-in=0 --fade-out=0 --lines=3 --age=1;
    # date +"%H:%M" | aosd_cat --shadow-offset=1 --back-color=black --back-opacity=200 --position=4 --padding=32 --fore-color=white --lines=0 --fade-in=0 --fade-out=0 --lines=3 --age=1;
    font_size="${1:-333}"
    fade_full="${2:-500}"
    padding="${3:-0}"

    # base_args=(
    #     --font="Ubuntu $font_size" --shadow-offset=1 --back-color=black --back-opacity=200 --fore-color=white --lines=0 --lines=3
    #     --fade-in=0 --fade-out=0 --fade-full=$fade_full --padding=$padding
    # )
    echo "Getting centers"
    # IFS='\n' read -r centers <<< $(aosd_get_centers_xy_args)
    # echo "$centers"
    # for pos_args in
    # for pos_args in $(aosd_get_centers_xy_args)
    for pos_args in "$(aosd_get_centers_xy_args)"
    # for pos_args in ${centers[@]}
    do
        echo "Showing time: $pos_args"
        IFS=' ' read -r -a pos_args_array <<< "$pos_args"
        full_args=(
            --font="Ubuntu $font_size" --shadow-offset=1 --back-color=black --back-opacity=200 --fore-color=white --lines=0 --lines=3
            --fade-in=0 --fade-out=0 --fade-full=$fade_full --padding=$padding
            ${pos_args_array[@]}
        )
        echo "Showing time: $full_args"
        date +"%H:%M" | aosd_cat "${full_args[@]}"

    done
}


