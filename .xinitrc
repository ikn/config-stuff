#! /bin/sh

if [ "$1" = light ]; then
    exec jsession /home/j/.jsession/conf-light
else
    exec jsession
fi
