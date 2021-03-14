#!/bin/sh

set -ex

SPEED=""
TARGET=${2:-Firmware}

if [ -z "$1" ]; then
  echo "Provide a model: uno|nano"
  exit 1
else
  if [ "$1" = "uno" ]; then
    SPEED="115200"
    PORT=COM4
  elif [ "$1" = "nano" ]; then
    SPEED="57600"
    PORT=COM3
  else
    echo "Invalid model, choose from: uno|nano"
    exit 2
  fi
fi

avr-objcopy -O ihex -R .eeprom  target/avr-atmega328p/release/${TARGET}.elf target/avr-atmega328p/release/${TARGET}.hex 
/mnt/e/Arduino/hardware/tools/avr/bin/avrdude.exe -Cavrdude.conf -v -patmega328p -carduino -P${PORT} -b${SPEED} -D -Uflash:w:target/avr-atmega328p/release/${TARGET}.hex:i
