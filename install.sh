#!/bin/bash
set -e
cd "$(dirname "$0")"

. ./wireguard/bin/lib.sh

cp -f wireguard/wg0.conf "$WIREGUARD_CONF"

./wireguard/bin/docker-entrypoint.sh
echo "You need to add your server as a peer"
./wireguard/bin/add-peer.sh

echo "Endpoint = $(ask "Server URL: ")" >> "$WIREGUARD_CONF"
