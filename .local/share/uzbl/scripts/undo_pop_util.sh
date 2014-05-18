undo_pop () {
    f="$1"
    line="$2"
    if [ -z "$line" ]; then
        uri="$(tail -n 1 "$f" 2> /dev/null)"
    else
        uri="$(sed -n "${line}p" "$f")"
    fi

    rtn=1
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
        if [ -z "$line" ]; then
            sed -i '$d' "$f"
        else
            sed -i "${line}d" "$f"
        fi
        [ "$(wc -l "$f" | cut -d" " -f1)" -eq 0 ] && rm "$f"
    }

    return "$rtn"
}
