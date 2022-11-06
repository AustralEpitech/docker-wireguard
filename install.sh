#!/bin/bash
cd "$(dirname "$0")" || exit 1

. ./wireguard/bin/lib.sh


create_default_conf

set -e

echo 'Now you need to add the key above to your server'

while [ -z "$IP" ]; do
    IP="$(ask "IP assigned by the server: ")"
    PUB="$(ask 'Server public key: ')"
    URL="$(ask 'Server address (ADDR:PORT): ')"
    if ! ask_yn 'Is This correct (yes/No)? '; then
        unset "IP"
        echo
    fi
done

wg set wg0 peer "$PUB" allowed-ips "0.0.0.0/0" endpoint "$URL"

ip addr add dev wg0 "$IP"
wg setconf wg0 "$WIREGUARD_CONF"
ip link set wg0

#wg quick
