#!/bin/bash
. lib.sh

PRIV="$(wg genkey)"

sed -i "s|\$PRIV|$PRIV|" "$WIREGUARD_CONF"
chmod 600 "$WIREGUARD_DIR"/*

wg-quick up wg0

exec "$@"
