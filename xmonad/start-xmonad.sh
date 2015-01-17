#!/bin/sh
#-----------------------------------------------------------------------
# Configures the session and launches the Xmonad window manager.
#-----------------------------------------------------------------------

# Ensure that the correct pointer is set.
xsetroot -cursor_name left_ptr

# Configure urxvt.
xrdb -merge $HOME/.local/etc/xorg/urxvt.conf

# Start compton (compositor).
compton -b --config /dev/null

# Set the wallpaper.
feh --bg-scale ~/wallpaper/got_direwolf.jpg

# Start Xmonad.
xmonad

