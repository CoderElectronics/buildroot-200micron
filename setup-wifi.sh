#!/bin/bash

SERIAL_PORT="/dev/ttyUSB0"
BAUD_RATE="115200"

if [ $# -lt 2 ]; then
    echo "Usage: $0 <ssid> <password>"
    echo "-> Both SSID and password arguments are required"
    echo "-> Configure serial port and baud rate by editing script"
    exit 1
fi

stty -F $SERIAL_PORT speed $BAUD_RATE cs8 -cstopb -parenb raw

send_cmd() {
    echo -ne "$1\n\r" > $SERIAL_PORT
}

watch_output() {
    # Read serial output for specified seconds (default 2)
    timeout "${1:-2}" cat < $SERIAL_PORT 2>/dev/null || true
}

ssid_escaped="${1//\'/\'\"\'\"\'}"
psk_escaped="${2//\'/\'\"\'\"\'}"

send_cmd "root"
sleep 1
send_cmd "echo | tee -a /etc/wpa_supplicant.conf"
sleep 0.5
send_cmd "wpa_passphrase '$ssid_escaped' '$psk_escaped' | tee -a /etc/wpa_supplicant.conf"
sleep 0.5
send_cmd "/etc/init.d/S97networking stop"
sleep 10
send_cmd "/etc/init.d/S97networking start"
sleep 20
send_cmd "ifconfig wlan0"

echo
watch_output 2
echo

echo "WiFi setup done"
