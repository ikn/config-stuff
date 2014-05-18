#!/bin/sh

# get from our undo list
echo "${UZBL_TABBED_SOCKET/\.socket/_undolist}"
# then from any orphaned list (has no corresponding socket)
for f in "$(dirname "$UZBL_TABBED_SOCKET")"/uzbltabbed_*_undolist; do
    [ -f "$f" ] && ! [ -S "${f/_undolist/.socket}" ] && echo "$f"
done
