#!/bin/bash
cd "$(dirname "$0")" || exit 1
. ./wireguard/bin/lib.sh

ip link delete dev wg0 type wireguard
rm -rf "$WIREGUARD_DIR"

set -e

mkdir -p "$WIREGUARD_DIR"
wg genkey | tee "$WIREGUARD_DIR/priv.key" | wg pubkey > "$WIREGUARD_DIR/pub.key"

chmod 600 "$WIREGUARD_DIR"/*

echo -e "You need to add this key to your server: $RED$(cat "$WIREGUARD_DIR/pub.key")$NORMAL"

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

export IP SERVER_PUB SERVER_URL SERVER_PORT

envsubst < peer.conf > "$WIREGUARD_CONF"

wg-quick up wg0
wg set wg0 private-key "$WIREGUARD_DIR/priv.key"
