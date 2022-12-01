#!/bin/bash
set -e
cd "$(dirname "$0")"
. ./wireguard/bin/lib.sh || true

ip link del dev wg0 || true

PRIV="$(wg genkey)"
PUB="$(wg pubkey <<< "$PRIV")"

echo -e "You need to add this key to your server: $RED$PUB$NORMAL"

while [ -z "$IP" ]; do
    IP="$(ask 'IP assigned by the server [10.0.0.2]: ' '10.0.0.2')"
    SERVER_PUB="$(ask 'Server public key: ')"
    SERVER_URL="$(ask 'Server address (URL/IP): ')"
    SERVER_PORT="$(ask 'Server port [443]: ' '443')"
    if ! ask_yn 'Is This correct (yes/No)? '; then
        unset IP
        echo
    fi
done

export IP PRIV SERVER_PUB SERVER_URL SERVER_PORT

envsubst < peer.conf > "$WIREGUARD_CONF"
chmod 600 "$WIREGUARD_DIR"/*

wg-quick up wg0
