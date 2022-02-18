#!/bin/bash

cd ~/parachains
# git clone https://github.com/DataHighway-DHX/node
git clone https://github.com/DataHighway-DHX/DataHighway-Parachain
cd DataHighway-Parachain

# git fetch origin polkadotv0.9.11:polkadotv0.9.11
# git branch
git stash
# git checkout polkadotv0.9.11

. ~/.cargo/env
PATH=$PATH:/root/.cargo/bin

# rustup update stable
# rustup toolchain install nightly-2020-10-06
# rustup target add wasm32-unknown-unknown --toolchain nightly-2020-10-06
# rustup default nightly-2020-10-06
# rustup override set nightly-2020-10-06

# rustup update stable
# rustup toolchain install nightly-2021-09-29
# rustup target add wasm32-unknown-unknown --toolchain nightly-2021-09-29
# rustup default nightly-2021-09-29
# rustup override set nightly-2021-09-29

# rustup update stable
# rustup toolchain install nightly-2021-11-07
# rustup target add wasm32-unknown-unknown --toolchain nightly-2021-11-07
# rustup default nightly-2021-11-07
# rustup override set nightly-2021-11-07

rustup update stable
rustup toolchain install nightly
rustup target add wasm32-unknown-unknown --toolchain nightly
rustup default nightly
rustup override set nightly

# rustup toolchain list

# cargo build --release
cargo build --release
# -p datahighway-collator
cp ./target/release/datahighway-collator ~/parachains/polkadot-launch/bin
# cp ./target/release/datahighway-collator ~/parachains/polkadot-launch/target/release
