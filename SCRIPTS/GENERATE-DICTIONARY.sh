#!/usr/bin/env bash

set -eu

./ULTRAFRENCHER/ULTRAFRENCHER --dict DICTIONARY.dict.txt --json          > DICTIONARY.json
./ULTRAFRENCHER/ULTRAFRENCHER --dict DICTIONARY.dict.txt --json --minify > DICTIONARY.min.json
./ULTRAFRENCHER/ULTRAFRENCHER --dict DICTIONARY.dict.txt                 > DICTIONARY.tex
