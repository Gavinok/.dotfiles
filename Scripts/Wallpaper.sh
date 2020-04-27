#!/bin/bash


#  ____                   _        _   _ _
# |  _ \ ___  _ __  _ __ (_) ___  | \ | (_)___ ___  __ _ _ __
# | |_) / _ \| '_ \| '_ \| |/ _ \ |  \| | / __/ __|/ _` | '_ \
# |  _ < (_) | | | | | | | |  __/ | |\  | \__ \__ \ (_| | | | |
# |_| \_\___/|_| |_|_| |_|_|\___| |_| \_|_|___/___/\__,_|_| |_|
#


DIR="$HOME/Pictures/wallpapers/" # Path to wallpapers
screen1=$(xrandr --listactivemonitors | grep "+" | awk '{print $4}' | awk NR==1) # Select the first screen for the dual function
screen2=$(xrandr --listactivemonitors | grep "+" | awk '{print $4}' | awk NR==2) # Select the second screen if attached for the dual function

# to set same wallpaper on both desktops
Single(){
    walls=$(sxiv -t -o $DIR | xargs)  # running sxiv, and marking either one or two files
    wall1=$(printf "%s" "$walls" | awk '{print $1}')  # Print the path to the first marked picture

    # if no picture is marked in sxiv, exit.
    if [ -z "$walls" ]
    then
      exit 0
    else
      $SingleWallMenu
    fi

    SingleWallMenu="dmenu -i -l 5 -p "Options""
    SingleWallOptions=$(echo -e "zoom\ncenter\ntile\nstretch\nno-randr" | $SingleWallMenu)

    xwallpaper --$SingleWallOptions $wall1  && sed -i "s|xwallpaper.*|xwallpaper  --$SingleWallOptions $wall1|" $HOME/.Scripts/defaultwallpaper.sh
}

# to set to diffrent wallpapers on each desktop
Dual() {
    dwalls=$(sxiv -t -o $DIR | xargs)  # running sxiv, and marking either one or two files
    dwall1=$(printf "%s" "$dwalls" | awk '{print $1}')  # Print the path to the first marked picture
    dwall2=$(printf "%s" "$dwalls" | awk '{print $2}')  # Print the path to the second marked picture

    # if no picture is marked in sxiv, exit.
    if [ -z "$dwalls" ]
    then
      exit 0
    else
      $FirstScreenMenu
    fi

    FirstScreenMenu="dmenu -i -l 4 -p "First_screen_options""
    FirstScreenOptions=$(echo -e "zoom\ncenter\ntile\nstretch" | $FirstScreenMenu)
    SecondScreenMenu="dmenu -i -l 4 -p "Second_screen_options""
    SecondScreenOptions=$(echo -e "zoom\ncenter\ntile\nstretch" | $SecondScreenMenu)

    xwallpaper --output $screen1 --$FirstScreenOptions $dwall1 --output $screen2 --$SecondScreenOptions $dwall2 && sed -i "s|xwallpaper.*|xwallpaper --output $screen1 --$FirstScreenOptions $dwall1 --output $screen2 --$SecondScreenOptions $dwall2|" $HOME/.Scripts/defaultwallpaper.sh
}

MENU="dmenu -l 2 -p "Mode?""
MODE=$(echo -e "Single: Choose one picture\nDual: Choose two pictures" | $MENU)
  case "$MODE" in
    Single*) Single ;;
    Dual*) Dual
  esac
