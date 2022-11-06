#!/bin/bash
. "$(dirname "$0")/lib.sh"

COUNT=$(grep -c AllowedIPs "$WIREGUARD_CONF")
IP="10.0.0.$((COUNT + 1))/24"

PUB=$(ask 'Peer Public Key: ')

add_peer "$PUB" "$IP"
echo "Here is your IP: $IP"
echo -n "Here is the public key of the server:"
cat "$WIREGUARD_DIR"/pub
