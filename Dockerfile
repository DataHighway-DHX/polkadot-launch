FROM ubuntu:latest AS stage-1

# bypass interactive prompt that disrupts docker build
ENV DEBIAN_FRONTEND=noninteractive

# create a project folder
WORKDIR /parachains/polkadot-launch

# copy all to project folder
COPY ./config.json /polkadot-launch

RUN apt-get update \
    && apt-get install -y build-essential wget cmake pkg-config libssl-dev \
    openssl git gcc clang libclang-dev curl vim unzip screen bash unzip \
    && curl https://getsubstrate.io -sSf | bash -s -- --fast \
    && wget -O - https://sh.rustup.rs | sh -s -- -y \
    && PATH=$PATH:/root/.cargo/bin \
    && rustup update stable \
    && rustup update nightly \
    # && rustup toolchain install nightly \
    # && rustup target add wasm32-unknown-unknown --toolchain nightly \
    # && rustup install stable-aarch64-unknown-linux-gnu \
    # && rustup default stable-aarch64-unknown-linux-gnu \
    # && rustup override set stable-aarch64-unknown-linux-gnu \
    # && rustup default nightly \
    # && rustup override set nightly \
    && cargo version \
    && which cargo \
    && rustc --version \
    && mkdir -p /parachains \
    && cd /parachains \
    && git clone https://github.com/DataHighway-DHX/polkadot-launch \
    && cd /parachains/polkadot-launch \
    && mkdir -p /parachains/polkadot-launch/bin \
    #
    && cd /parachains \
    && git clone https://github.com/DataHighway-DHX/DataHighway-Parachain \
    && cd DataHighway-Parachain \
    && git stash \
    # && . ~/.cargo/env \
    # && PATH=$PATH:/root/.cargo/bin \
    && rustup update stable \
    && rustup toolchain install nightly-aarch64-unknown-linux-gnu \
    && rustup target add wasm32-unknown-unknown --toolchain nightly-aarch64-unknown-linux-gnu \
    && rustup default nightly-aarch64-unknown-linux-gnu \
    && rustup override set nightly-aarch64-unknown-linux-gnu \
    && cargo build --release \
    && cp ./target/release/datahighway-collator /parachains/polkadot-launch/bin \
    #
    && cd /parachains \
    && git clone https://github.com/paritytech/polkadot \
    && cd polkadot \
    && git stash \
    && git checkout v0.9.13 \
    # && . ~/.cargo/env \
    # && PATH=$PATH:/root/.cargo/bin \
    && rustup update stable \
    && rustup toolchain install nightly-aarch64-unknown-linux-gnu \
    && rustup target add wasm32-unknown-unknown --toolchain nightly-aarch64-unknown-linux-gnu \
    && rustup default nightly-aarch64-unknown-linux-gnu \
    && rustup override set nightly-aarch64-unknown-linux-gnu \
    && cargo build --release \
    && cp ./target/release/polkadot /parachains/polkadot-launch/bin/polkadot \
    # 
    && cd /parachains/polkadot-launch \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && . ~/.bash_profile \
    && nvm install v16.3.0 \
    && nvm use v16.3.0 \
    && npm install -g yarn \
    && yarn \
    && cat ./config.json \
    && yarn start config.json

    # && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    # && apt-get install -y nodejs \
    # && npm install -g yarn \

