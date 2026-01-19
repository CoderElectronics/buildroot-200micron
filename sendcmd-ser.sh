#!/bin/bash

SERIAL_PORT="/dev/ttyUSB0"
BAUD_RATE="115200"

if [ $# -lt 1 ]; then
    echo "Usage: $0 \"<command>\""
    echo "-> Configure serial port and baud rate by editing script"
    exit 1
fi

stty -F $SERIAL_PORT speed $BAUD_RATE cs8 -cstopb -parenb raw
echo -ne "$1\n\r" > $SERIAL_PORT
