
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
#/bin/bash -c "sleep 1.8 && xrandr --output LVDS1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output HDMI1 --off"
Wall-d -r &
#dwmstatbar &
xrdb ~/.Xresources &

exec spectrwm
