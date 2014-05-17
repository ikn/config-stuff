#!/bin/sh

# TODO: work with q
    # make it trigger some sort of event for each tab
# TODO: U does dmenu with all closed tabs
#   nl -s " " -w 1 -b a -n ln "$f" | ...
#   lineno=$(... | cut -d" " -f1)
#   sed -i "${lineno}d" "$f"

# don't save blank tabs
[ "$UZBL_URI" != about:blank ] && {
    f="${UZBL_TABBED_SOCKET/\.socket/_undolist}"
    # prune
    [ -f "$f" ] && [ "$(wc -l "$f" | cut -d" " -f1)" -ge 50 ] && \
        sed -i "1d" "$f"
    # append
    echo "$UZBL_URI" >> "$f"
}
