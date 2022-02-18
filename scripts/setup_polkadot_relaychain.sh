#!/bin/bash

cd ~/parachains
git clone https://github.com/paritytech/polkadot
cd polkadot
git stash
git checkout v0.9.16

. ~/.cargo/env
PATH=$PATH:/root/.cargo/bin
# rustup update
# rustup toolchain install nightly-2021-11-07
# rustup target add wasm32-unknown-unknown --toolchain nightly-2021-11-07
# rustup default nightly-2021-11-07
# rustup override set nightly-2021-11-07
rustup update stable
rustup toolchain install nightly
rustup target add wasm32-unknown-unknown --toolchain nightly
rustup default nightly
rustup override set nightly

# required for Apple M1 (otherwise get illegal hardware instruction error)
# https://github.com/paritytech/subport/issues/242#issuecomment-923678332
rustup install stable-aarch64-apple-darwin
rustup default stable-aarch64-apple-darwin
rustup override set stable-aarch64-apple-darwin

cargo build --release
cp ./target/release/polkadot ~/parachains/polkadot-launch/bin/polkadot

./target/release/polkadot build-spec --chain=rococo-local --disable-default-bootnode > rococo-local.json
./target/release/polkadot build-spec --chain rococo-local.json --raw --disable-default-bootnode > rococo-local-raw.json
cp ./rococo-local.json ~/parachains/polkadot-launch
cp ./rococo-local-raw.json ~/parachains/polkadot-launch
