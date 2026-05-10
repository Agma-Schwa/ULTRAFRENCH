#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"

## Build the generator.
pushd ../../../tools/dictionary-generator
cargo build --release
exe="$(realpath target/release/generator)"
popd

cd ..

GENERATE() {
    "$exe" DICTIONARY/DICTIONARY.dict.txt "$@"
}

## Generate JSON Dictionary.
GENERATE --search          > DICTIONARY/DICTIONARY.json
GENERATE --search --minify > DICTIONARY/DICTIONARY.min.json