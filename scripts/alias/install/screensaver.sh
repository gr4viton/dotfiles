
inst_screensaver () {

echo ">>> screensaver"
inst xscreensaver xscreensaver-data-extra xscreensaver-gl-extra xscreensaver-screensaver-bsod
echo ">>> electricsheep via https://ubuntuforums.org/showthread.php?t=355607"
# electricsheep
inst_add_repo ichthyo/zeug

inst electricsheep

# electricsheep setup
local nick="$USER"
local save_dir="~/.config/electricsheep"

mkdir $save_dir
local cmd=$(cat << EOF
#!/bin/sh
exec electricsheep --nick $nick --root 1 --max-megabytes 2000 --zoom 1 --display-anim 1 --show-errors 0 --nrepeats 2 --frame-rate 30 --save-dir $save_dir

EOF
)

local xsc_esheep="/usr/lib/xscreensaver/esheep.sh"
echo "> creating $xsc_esheep"
sudo sh -c "echo \"$cmd\" > $xsc_esheep"

sudo chmod 755 $xsc_esheep

local ico=$(cat << EOF
[Desktop Entry]
Encoding=UTF-8
Name=ElectricSheep
Comment=Electric Sheep is a distributed screen-saver that harnesses idle computers into a render farm with the purpose of animating and evolving artificial life-forms. This module requires a high-bandwidth, always-on connection to the internet such as DSL or cable-modem. The first time you run it, it normally takes 5 to 10 minutes before the first sheep is downloaded and displayed. After that, it should come up immediately. If you have installed the hacked xscreensaver that supports passing key-presses onto the graphics hack and this feature is enabled, then pressing the up arrow-key transmits a vote for the currently displayed sheep to the server. The votes are the basis of a fitness function for an evolutionary algorithm on the sheep genomes. Vote for the sheep you like, and they will mate, reproduce, and evolve! See http://electricsheep.org for more information. This is version 2.6.8.
TryExec=esheep.sh
Exec="esheep.sh"
StartupNotify=false
Terminal=false
Type=Application
Categories=Screensaver
EOF
)

sudo mkdir -p "/usr/share/gnome-screensaver/themes/"
local xsc_theme="/usr/share/gnome-screensaver/themes/electricsheep.desktop"
echo "> creating $xsc_theme"

sudo sh -c "echo \"$ico\" > $xsc_theme"

gconftool-2 --type int --set /apps/gnome-screensaver/cycle-delay 10000

}
