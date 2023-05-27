#! /bin/sh

# (hopefully temporary) dbus fix (for libnotify)
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

exec jsession /home/j/.jsession/conf-bspwm-"${1:-full}"
