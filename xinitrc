# set the cursor
xsetroot -cursor_name left_ptr &
# set Caps -> Ctrl
setxkbmap -option ctrl:nocaps &
# start emacs
emacs --daemon &
# turn off touchpas
synclient TouchpadOff=1 &
# wallpaper
feh --bg-scale $WALLPAPER &
# screen saver
xscreensaver -no-splash &
# gpg agent
eval $(gpg-agent --daemon) &
# pulse
pulseaudio --start &
# dropbox
dropboxd &
# start xmonad
exec xmonad
