#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"
cd ..

./SCRIPTS/GENERATE-DICTIONARY.sh > DICTIONARY.tex
xelatex GRAMMAR.tex