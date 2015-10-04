#! /bin/sh

# (hopefully temporary) dbus fix
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

exec "$@"
