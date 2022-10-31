#!/bin/bash
. "$(dirname "$0")/lib.sh"

IP="10.0.0.$(grep -c AllowedIPs "$WIREGUARD_CONF")/24"

while [ -z "$PUB" ]; do
    PUB=$(ask 'Peer Public Key: ')

    echo -e "${RED}$PUB${NORMAL}"
    if ! ask_yn 'Is this correct (yes/No)? '; then
        unset PUB
    fi
done

cat << EOF >> "$WIREGUARD_CONF"

[Peer]
PublicKey = $PUB
AllowedIPs = $IP
EOF
