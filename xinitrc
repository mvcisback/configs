# set the cursor
xsetroot -cursor_name left_ptr &
# set Caps -> Ctrl
setxkbmap -option ctrl:nocaps &
# start emacs
emacs --daemon &
# wallpaper
feh --bg-scale $WALLPAPER &
# gpg agent
eval $(gpg-agent --daemon --enable-ssh-support --pinentry-program $PINENTRY) &
# pulse
pulseaudio --start &
# Terminal daemon
dunst&
xrdb ~/.Xresources &
# Terminfo
export TERMINFO=~/.terminfo
# start xmonad
exec xmonad
