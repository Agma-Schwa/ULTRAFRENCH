#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"
cd ..

./SCRIPTS/BUILD.sh
scp DICTIONARY/DICTIONARY.min.json admin@nguhserver:/srv/nguh.org/static/DICTIONARY.json
scp GRAMMAR.pdf                    admin@nguhserver:/srv/nguh.org/static/UF-GRAMMAR.pdf
