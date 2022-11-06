#!/bin/bash
. lib.sh

wg genkey | tee "$WIREGUARD_DIR"/priv.key | wg pubkey > "$WIREGUARD_DIR"/pub.key
PRIV="$(cat "$WIREGUARD_DIR/priv.key")"
export PRIV

CONF="$(envsubst < "$WIREGUARD_CONF")"
echo "$CONF" > "$WIREGUARD_CONF"
wg-quick up wg0

chmod 600 "$WIREGUARD_DIR"/*

exec "$@"
