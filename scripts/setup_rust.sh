#!/bin/bash

wget -O - https://sh.rustup.rs | sh -s -- -y
PATH=$PATH:/root/.cargo/bin
rustup update stable
rustup update nightly
cargo version
which cargo
rustc --version
