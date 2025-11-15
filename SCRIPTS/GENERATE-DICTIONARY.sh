#!/usr/bin/env bash

set -eu

GENERATE() {
    ./ULTRAFRENCHER/ULTRAFRENCHER --dict DICTIONARY.dict.txt "$@"
}

## Generate JSON Dictionary.
GENERATE --json          > DICTIONARY.json
GENERATE --json --minify > DICTIONARY.min.json

## Generate Typst Dictionary.
DICTIONARY_CONTENTS='#import "DICTIONARY-DEFS.typ" : *'
DICTIONARY_CONTENTS+=$'\n'
DICTIONARY_CONTENTS+="$(GENERATE)"
echo "$DICTIONARY_CONTENTS" > DICTIONARY.typ