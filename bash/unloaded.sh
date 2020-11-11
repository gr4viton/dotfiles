# contains parts of scripts which are no longer loaded
# - when the script is no longer needed
# - when i am not sure what it was used for in the first place

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    os_name="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    os_name="mac"
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    os_name="cygwin"
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    os_name="mingw"
elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
    os_name="win32"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    # ...
    os_name="freebsd"
else
    # Unknown.
    os_name="unknown"
fi


# colorscheme from
# http://ciembor.github.io/4bit/#

# data:text/plain,%23!%2Fbin%2Fbash %0A%0A%23 Save this script into set_colors.sh%2C make this file executable and run it%3A %0A%23 %0A%23 %24 chmod %2Bx set_colors.sh %0A%23 %24 .%2Fset_colors.sh %0A%23 %0A%23 Alternatively copy lines below directly into your shell. %0A%0Agconftool-2 --set %2Fapps%2Fgnome-terminal%2Fprofiles%2FDefault%2Fuse_theme_background --type bool false %0Agconftool-2 --set %2Fapps%2Fgnome-terminal%2Fprofiles%2FDefault%2Fuse_theme_colors --type bool false %0Agconftool-2 -s -t string %2Fapps%2Fgnome-terminal%2Fprofiles%2FDefault%2Fbackground_color '%23393902022727'%0Agconftool-2 -s -t string %2Fapps%2Fgnome-terminal%2Fprofiles%2FDefault%2Fforeground_color '%23d9d9e6e6f2f2'%0Agconftool-2 -s -t string %2Fapps%2Fgnome-terminal%2Fprofiles%2FDefault%2Fpalette '%23000000000000%3A%23bdbd4c4c4f4f%3A%234f4fbdbd4c4c%3A%23bdbdbaba4c4c%3A%234c4c4f4fbdbd%3A%23baba4c4cbdbd%3A%234c4cbdbdbaba%3A%23e1e1e1e1e1e1%3A%231a1a1a1a1a1a%3A%23e8e8bfbfc0c0%3A%23c0c0e8e8bfbf%3A%23e8e8e6e6bfbf%3A%23bfbfc0c0e8e8%3A%23e6e6bfbfe8e8%3A%23bfbfe8e8e6e6%3A%23ffffffffffff'%0A

# Save this script into set_colors.sh, make this file executable and run it:
#
# $ chmod +x set_colors.sh
# $ ./set_colors.sh
#
# Alternatively copy lines below directly into your shell.

#if [ -n $set_colors_gconftool ]
#then
#	gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_theme_background --type bool false
#	gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_theme_colors --type bool false
#	gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/background_color '#393902022727'
#	gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/foreground_color '#d9d9e6e6f2f2'
#	gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/palette '#000000000000:#bdbd4c4c4f4f:#4f4fbdbd4c4c:#bdbdbaba4c4c:#4c4c4f4fbdbd:#baba4c4cbdbd:#4c4cbdbdbaba:#e1e1e1e1e1e1:#1a1a1a1a1a1a:#e8e8bfbfc0c0:#c0c0e8e8bfbf:#e8e8e6e6bfbf:#bfbfc0c0e8e8:#e6e6bfbfe8e8:#bfbfe8e8e6e6:#ffffffffffff'
#fi



