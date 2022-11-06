#!/bin/bash
cd "$(dirname "$0")" || exit 1

. ./wireguard/bin/lib.sh

set -e

create_default_conf

echo 'Now you need to add the key above to your server'

IP="$(ask "IP assigned by the server: ")"
PUB=$(ask 'Server public key: ')

./wireguard/bin/add-peer.sh "$PUB" "0.0.0.0/0"

echo "Endpoint = $(ask "Server URL: ")" >> "$WIREGUARD_CONF"

ip address add dev wg0 "$IP"
wg setconf wg0 "$WIREGUARD_CONF"
ip link set up dev wg0

#wg quick
