# set the cursor
xsetroot -cursor_name left_ptr &
# set Caps -> Ctrl
setxkbmap -option ctrl:nocaps &
# start emacs
emacs --daemon &
# wallpaper
feh --bg-scale $WALLPAPER &
# gpg agent
eval $(gpg-agent --daemon) &
# pulse
pulseaudio --start &
# Terminal daemon
urxvtd &
# start xmonad
exec xmonad
