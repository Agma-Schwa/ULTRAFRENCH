#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"
cd ..

## Build plugin.
pushd PLUGIN
rustup target add wasm32-unknown-unknown
cargo build --release --target wasm32-unknown-unknown --lib
popd

## Generate JSON dictionary.
./SCRIPTS/GENERATE-DICTIONARY.sh

## Compile the grammar.
typst compile GRAMMAR.typ
