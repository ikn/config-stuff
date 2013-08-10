#! /bin/sh

if [ -z "$1" ]; then
    session=light
else
    session="$1"
fi

if [ "$session" = full ]; then
    /home/j/.startup &
    exec jsession /home/j/.jsession/conf-full
else # "$session" = light
    /home/j/.startup light &
    exec jsession
fi
