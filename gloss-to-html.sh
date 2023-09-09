#!/usr/bin/env bash

set -f
text="$*"
text="${text//\\Sl /\\}"
text="${text//\\s{/<\$s}"
text="${text//\}/>}"
text="${text//|/ }"
echo -n $text | xclip -sel clip