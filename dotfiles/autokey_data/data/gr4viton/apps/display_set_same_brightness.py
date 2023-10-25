import os 
# os.system("/bin/bash -c 'source /home/dd/dd/dotfiles/bash/alias/office.sh; monitors_dim'")
#os.system("urxvt -e 'bash -c \"tiz_art proffesor\" '")
    # os.system("gnome-terminal -e 'bash -c \"ls; bash\" '")
    # os.system("kitty -e 'bash -c \"exec bash; mousepad; exec bash\" '")
os.system('''
xrandr --output "eDP-1" --brightness 0.4;
xrandr --output "DP-3" --brightness 0.4;
''')