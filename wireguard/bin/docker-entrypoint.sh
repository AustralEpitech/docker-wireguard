#!/bin/bash
. lib.sh

wg genkey | tee "$WIREGUARD_DIR"/priv.key | wg pubkey > "$WIREGUARD_DIR/pub.key"

chmod 600 "$WIREGUARD_DIR"/*

wg-quick up wg0
wg set wg0 private-key "$WIREGUARD_DIR/priv.key"

exec "$@"
