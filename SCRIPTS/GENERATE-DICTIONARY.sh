#!/usr/bin/env bash

set -eu

GENERATE() {
    ./PLUGIN/target/release/ULTRAFRENCHER DICTIONARY/DICTIONARY.dict.txt "$@"
}

## Build the ULTRAFRENCHER.
pushd PLUGIN
cargo build --release --bin ULTRAFRENCHER
popd

## Generate JSON Dictionary.
GENERATE          > DICTIONARY/DICTIONARY.json
GENERATE --minify > DICTIONARY/DICTIONARY.min.json