#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"
cd ..

./SCRIPTS/GENERATE-DICTIONARY.sh
latexmk -pdfxe -xelatex="xelatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S" GRAMMAR.tex
