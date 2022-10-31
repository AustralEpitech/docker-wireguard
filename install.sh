#!/bin/bash
. ./wireguard/bin/lib.sh

./wireguard/bin/docker-entrypoint.sh
echo "You need to add your server as a peer"
./wireguard/bin/add-peer.sh

echo "Endpoint = $(ask "Server URL: ")" >> "$WIREGUARD_CONF"
