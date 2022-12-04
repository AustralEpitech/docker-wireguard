#!/bin/bash
. lib.sh

PRIV="$(wg genkey)"
DEV="$(ip route show | grep default | grep -Po '(?<=dev\s)\w+')"

sed -i "s|\$PRIV|$PRIV|; s/\$DEV/$DEV/" "$WIREGUARD_CONF"
chmod 600 "$WIREGUARD_DIR"/*

wg-quick up wg0

exec "$@"
