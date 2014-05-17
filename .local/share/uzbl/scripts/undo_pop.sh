#!/bin/bash

_uzbl_undo_pop () {
    f="$1"
    rtn=1
    uri="$(tail -n 1 "$f" 2> /dev/null)"
    [ -n "$uri" ] && {
        if [ "$UZBL_URI" = about:blank ]; then
            echo "uri $uri"
        else
            echo "event NEW_TAB $uri"
        fi > "$UZBL_FIFO"
        rtn=0
    }

    # cleanup
    [ -f "$f" ] && {
        sed -i '$d' "$f"
        [ "$(wc -l "$f" | cut -d" " -f1)" -eq 0 ] && rm "$f"
    }

    echo "$rtn"
    return "$rtn"
}

# try to pop from our undo list
_uzbl_undo_pop "${UZBL_TABBED_SOCKET/\.socket/_undolist}" || \
    # then from any orphaned list (has no corresponding socket)
    for f in "$(dirname "$UZBL_TABBED_SOCKET")"/uzbltabbed_*_undolist; do
        echo "$f"
        [ -f "$f" ] && ! [ -S "${f/_undolist/.socket}" ] && \
            _uzbl_undo_pop "$f" && break
    done
