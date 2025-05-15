#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"
cd ..

./SCRIPTS/GENERATE-DICTIONARY.sh
latexmk -xelatex GRAMMAR.tex
