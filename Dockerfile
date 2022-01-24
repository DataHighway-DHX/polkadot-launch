FROM ubuntu:latest AS stage-1

# bypass interactive prompt that disrupts docker build
ENV DEBIAN_FRONTEND=noninteractive

# create a project folder
WORKDIR /polkadot-launch

# copy all to project folder
COPY ./config/config.json /polkadot-launch

RUN apt-get update \
    && apt-get install -y build-essential wget cmake pkg-config libssl-dev \
    openssl git gcc clang libclang-dev curl vim unzip screen bash unzip \
    && curl https://getsubstrate.io -sSf | bash -s -- --fast \
    && wget -O - https://sh.rustup.rs | sh -s -- -y \
    && PATH=$PATH:/root/.cargo/bin \
    && rustup update stable \
    && rustup update nightly \
    && rustup target add wasm32-unknown-unknown \
    && rustup install stable-aarch64-unknown-linux-gnu \
    && rustup default stable-aarch64-unknown-linux-gnu \
    && rustup override set stable-aarch64-unknown-linux-gnu \
    && cargo version \
    && which cargo \
    && rustc --version \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn \
    && mkdir -p /polkadot-launch/bin \
    && cd /polkadot-launch \
    && git clone https://github.com/paritytech/cumulus \
    && cd cumulus \
    && git checkout polkadot-v0.9.13 \
    && cargo build --release -p polkadot-collator \
    && cp ./target/release/polkadot-collator /polkadot-launch/bin 
    # \
    # && cd /polkadot-launch \
    # && git clone https://github.com/paritytech/polkadot \
    # && cd polkadot \
    # && git checkout v0.9.13 \
    # && cargo build --release \
    # && cp ./target/release/polkadot /polkadot-launch/bin \
    # && cd /polkadot-launch \
    # && git clone https://github.com/DataHighway-DHX/node \
    # && cd node \
    # && git fetch origin polkadotv0.9.11:polkadotv0.9.11 \
    # && git checkout -b polkadotv0.9.11 \
    # && cargo build --release \
    # && cp ./target/release/datahighway-collator /polkadot-launch/bin \
    # && cd /polkadot-launch \
    # && node --version \
    # && yarn \
    # && yarn start ./config.json
