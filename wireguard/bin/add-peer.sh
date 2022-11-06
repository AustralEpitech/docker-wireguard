#!/bin/bash
. lib.sh

COUNT="$(grep -c AllowedIPs "$WIREGUARD_CONF")"
IP="10.0.0.$((COUNT + 2))"

while [ -z "$PUB" ]; do
    PEER_PUB=$(ask 'Peer Public Key: ')
    if ! ask_yn 'Is This correct (yes/No)? '; then
        unset "ans"
        echo
    fi
done

cat << EOF >> "$WIREGUARD_CONF"

[Peer]
PublicKey = $PEER_PUB
AllowedIPs = $IP
EOF

echo -e "Here is your IP: $RED$IP$NORMAL"
echo -e "Here is the public key of the server: $RED$(wg show wg0 private-key)$NORMAL"
