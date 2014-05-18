#!/bin/bash

DMENU_SCHEME="history"
DMENU_OPTIONS="xmms vertical resize"

. "/usr/share/uzbl/examples/data/scripts/util/dmenu.sh"
. "$(dirname "$0")"/undo_pop_util.sh

IFS=$'\n' fs=($("$(dirname "$0")"/undo_sources.sh))
lengths=()
for f in "${fs[@]}"; do
    length="$({ wc -l "$f" 2> /dev/null || echo 0; } | cut -d " " -f 1)"
    lengths+=("$length")
done

choice="$(
    line=0
    for i in ${!fs[*]}; do
        tac "${fs[i]}" 2> /dev/null | nl -v "$line" -s " " -w 1 -b a -n ln
        length="${lengths[i]}"
        line=$((line+length))
    done | dmenu
)"

chosenline="$(echo "$choice" | cut -d " " -f 1)"
uri="$(echo "$choice" | cut -d " " -f 2-)"

first_line=0
for i in ${!fs[*]}; do
    length="${lengths[i]}"
    if [ "$((first_line+length))" -gt "$chosenline" ]; then
        undo_pop "${fs[i]}" "$((length-(chosenline-first_line)))"
        break
    else
        first_line="$((first_line+length))"
    fi
done
