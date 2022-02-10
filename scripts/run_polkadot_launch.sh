#!/bin/bash

cp ./config.json ~/parachains/polkadot-launch
cp ./rococo-local-raw.json ~/parachains/polkadot-launch
cp ./rococo-local.json ~/parachains/polkadot-launch

./scripts/setup_substrate.sh
./scripts/setup_rust.sh
./scripts/setup_datahighway_polkadot_launch.sh
./scripts/setup_datahighway_parachain.sh
# ./scripts/setup_cumulus_parachain.sh
./scripts/setup_polkadot_relaychain.sh

cd ~/parachains/polkadot-launch
git branch
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install v16.3.0
nvm use v16.3.0
npm install -g yarn
yarn
cat ./config.json
yarn start config.json
