#!/bin/sh

DMENU_SCHEME="history"
DMENU_OPTIONS="xmms vertical resize"

. "/usr/share/uzbl/examples/data/scripts/util/dmenu.sh"
. "/usr/share/uzbl/examples/data/scripts/util/uzbl-dir.sh"

[ -r "$UZBL_HISTORY_FILE" ] || exit 1

uri="$(
    # unique by URL, taking the most recent occurrence
    tac "$UZBL_HISTORY_FILE" | sort -u -k 2,2 | \
    # sort by reverse date
    sort -n -r | \
    # remove date for selection
    cut -d " " -f 2- | $DMENU | \
    # extract URL
    cut -d " " -f 1)"
[ -n "$uri" ] && echo "$@ $uri" > "$UZBL_FIFO"
