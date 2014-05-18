#!/bin/bash

. "$(dirname "$0")"/undo_pop_util.sh

"$(dirname "$0")"/undo_sources.sh | while read f; do
    undo_pop "$f" && break
done
