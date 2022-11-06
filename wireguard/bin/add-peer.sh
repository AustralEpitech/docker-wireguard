#!/bin/bash
. "$(dirname "$0")/lib.sh"

COUNT=$(grep -c AllowedIPs "$WIREGUARD_CONF")
IP="10.0.0.$((COUNT + 1))"

while [ -z "$PUB" ]; do
    PUB=$(ask 'Peer Public Key: ')
    if ! ask_yn 'Is This correct (yes/No)? '; then
        unset "ans"
        echo
    fi
done

wg set wg0 peer "$PUB" allowed-ips "$IP"
echo -e "Here is your IP: $RED$IP$NORMAL"
echo -e "Here is the public key of the server: $RED$(cat "$WIREGUARD_DIR/pub")$NORMAL"
