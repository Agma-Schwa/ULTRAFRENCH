#!/usr/bin/env bash

set -eu

## Join line continuations, sort, preprocess, sort again, and generate dictionary.
sed -e ':x /\\$/ { N; s/\\\n//g ; bx }' DICTIONARY.txt \
| sort                                                 \
| awk -F '|' -f SCRIPTS/PREPROCESS.awk                 \
| sort                                                 \
| awk -F '|' -f SCRIPTS/GENERATE.awk                   \
> DICTIONARY.tex
