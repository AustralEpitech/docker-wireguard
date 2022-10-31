#!/bin/bash
. lib.sh

function get_local_ip4() {
    ip -4 route get 1 | grep -oP '(\d{1,3}\.){3}\d{1,3}(?= uid)'
}

PRIVATE_KEY="$(wg genkey)"

sed -i "/^PrivateKey\s*=\s*/ s#\$#$PRIVATE_KEY#" "$WIREGUARD_CONF"

ip link add dev wg0 type wireguard
ip address add dev wg0 "$(get_local_ip4)"
wg setconf wg0 "$WIREGUARD_CONF"
ip link set up dev wg0

exec "$@"
