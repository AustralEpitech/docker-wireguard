#!/bin/bash

function ask_yn() {
    local ans

    echo -en "$1" 1>&2
    read -r ans
    case "${ans,,}" in
        y|yes)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

function ask() {
    local ans

    while [ -z "$ans" ]; do
        echo -en "$1" 1>&2
        read -r ans
    done
    echo "$ans"
}

function create_default_conf() {
    ip link delete dev wg0 type wireguard
    rm -rf "$WIREGUARD_DIR"
    mkdir -p "$WIREGUARD_DIR"

    wg genkey | tee "$WIREGUARD_DIR/priv" | wg pubkey > "$WIREGUARD_DIR/pub"

    cat << EOF > "$WIREGUARD_CONF"
[Interface]
PrivateKey = $(cat "$WIREGUARD_DIR/priv")
ListenPort = 443
EOF

    ip link add dev wg0 type wireguard
    cat "$WIREGUARD_DIR/pub"
}

if [ -t 1 ]; then
    export NORMAL='\e[0m'
    export RED='\e[31m'
fi

export WIREGUARD_DIR=/etc/wireguard
export WIREGUARD_CONF="$WIREGUARD_DIR/wg0.conf"

if ! chmod 700 "$WIREGUARD_DIR"; then
    echo "Try again with sudo." 1>&2
    exit 1
fi
