#!/bin/bash

if [ "$1" == "setup" ]; then
  rustup override set nightly-2021-01-05-x86_64-unknown-linux-gnu
fi

cargo build -Z build-std=core  --target avr-atmega328p.json --release
