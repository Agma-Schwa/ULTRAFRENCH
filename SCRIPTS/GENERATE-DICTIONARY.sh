#!/usr/bin/env bash

set -eu

./ULTRAFRENCHER/ULTRAFRENCHER --dict DICTIONARY.txt --json          > DICTIONARY.json
./ULTRAFRENCHER/ULTRAFRENCHER --dict DICTIONARY.txt --json --minify > DICTIONARY.min.json
./ULTRAFRENCHER/ULTRAFRENCHER --dict DICTIONARY.txt                 > DICTIONARY.tex
