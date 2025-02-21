#!/bin/bash

sudo apt install -y curl git build-essential pkg-config libssl-dev unzip
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup update
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
cargo install protobuf-codegen
rustup target add riscv32i-unknown-none-elf
rustup component add rust-src
mkdir -p $HOME/.nexus
cd $HOME/.nexus
git clone https://github.com/nexus-xyz/network-api
cd network-api
git fetch --tags
git checkout $(git rev-list --tags --max-count=1)
cd clients/cli
cargo clean
cargo build --release
rustup target add riscv32i-unknown-none-elf
