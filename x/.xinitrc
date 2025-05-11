#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# not required since we use autostart
# xbindkeys &

# not required to be rerun if `sudo alsactl store` successfuly saves settings
#amixer -c PCH cset 'name=Headphone Mic Boost Volume' 1 &

#transmission-daemon

# picom --config ~/.config/picom/picom.conf -b &
# pulseeffects --gapplication-service &

xcompmgr -f -I0.056 -O0.06 &
slstatus &
~/.fehbg &

exec dwm
