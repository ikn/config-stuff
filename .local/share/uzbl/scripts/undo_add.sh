#!/bin/sh

# don't save blank tabs
[ "$UZBL_URI" != about:blank ] && {
    f="${UZBL_TABBED_SOCKET/\.socket/_undolist}"
    # prune
    [ -f "$f" ] && [ "$(wc -l "$f" | cut -d" " -f1)" -ge 50 ] && \
        sed -i "1d" "$f"
    # append
    echo "$UZBL_URI" >> "$f"
}
