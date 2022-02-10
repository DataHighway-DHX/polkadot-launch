#!/bin/bash

cd ~/parachains
git clone https://github.com/paritytech/polkadot
cd polkadot
git stash
git checkout v0.9.13

. ~/.cargo/env
PATH=$PATH:/root/.cargo/bin
# rustup update
# rustup install stable-aarch64-apple-darwin
# rustup default stable-aarch64-apple-darwin
# rustup toolchain install nightly-2021-11-07
# rustup target add wasm32-unknown-unknown --toolchain nightly-2021-11-07
# rustup default nightly-2021-11-07
# rustup override set nightly-2021-11-07
rustup update stable
rustup toolchain install nightly
rustup target add wasm32-unknown-unknown --toolchain nightly
rustup default nightly
rustup override set nightly

cargo build --release
cp ./target/release/polkadot ~/parachains/polkadot-launch/bin/polkadot


