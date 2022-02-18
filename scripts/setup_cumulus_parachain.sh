#!/bin/bash

cd ~/parachains
git clone https://github.com/paritytech/cumulus
cd cumulus

git stash

. ~/.cargo/env
PATH=$PATH:/root/.cargo/bin

rustup update
rustup toolchain install nightly-2021-11-07
rustup target add wasm32-unknown-unknown --toolchain nightly-2021-11-07
rustup default nightly-2021-11-07
rustup override set nightly-2021-11-07

git checkout polkadot-v0.9.16
cargo build --release -p polkadot-collator
cp ./target/release/polkadot-collator ~/parachains/polkadot-launch/bin
