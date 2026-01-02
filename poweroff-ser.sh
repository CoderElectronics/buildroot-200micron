#!/bin/bash

SERIAL_PORT="/dev/ttyUSB0"
BAUD_RATE="115200"

stty -F $SERIAL_PORT speed $BAUD_RATE cs8 -cstopb -parenb raw
echo -ne "root\n\r" > $SERIAL_PORT
echo -ne "poweroff\n\r" > $SERIAL_PORT

cat $SERIAL_PORT
