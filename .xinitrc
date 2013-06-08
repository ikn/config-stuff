#! /bin/sh

if [ "$1" = light ]; then
    /home/j/.startup light &
    exec jsession
else
    /home/j/.startup
    exec jsession /home/j/.jsession/conf-full
fi
