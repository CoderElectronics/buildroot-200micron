#!/bin/bash

SERIAL_PORT="/dev/ttyUSB0"
BAUD_RATE="115200"

if [ "$1" == "--help" ]; then
    echo "Usage: $0"
    echo "-> Configure serial port and baud rate by editing script"
    exit 1
fi

stty -F $SERIAL_PORT speed $BAUD_RATE cs8 -cstopb -parenb raw

send_cmd() {
    echo -ne "$1\n\r" > $SERIAL_PORT
}

generate_code() {
  tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 5
}

unique_code=$(generate_code)
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_$unique_code
pubkey="$(cat ~/.ssh/id_ed25519_$unique_code.pub)"

send_cmd "root"
sleep 1
send_cmd "mkdir .ssh"
sleep 0.5
send_cmd "echo \"$pubkey\" | tee -a ~/.ssh/authorized_keys"
sleep 0.5
send_cmd "/etc/init.d/S96tinysshd stop"
sleep 5
send_cmd "/etc/init.d/S96tinysshd start"

echo "Key pair setup done, try 'ssh root@<wifi-ip>'"
