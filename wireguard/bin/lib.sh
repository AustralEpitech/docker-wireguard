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
    local default="$2"
    local ans

    while [ -z "$ans" ]; do
        echo -en "$1" 1>&2
        read -r ans
        ans="${ans:-$default}"
    done
    echo "$ans"
}

if [ -t 1 ]; then
    export NORMAL='\e[0m'
    export RED='\e[31m'
fi

export WIREGUARD_DIR='/etc/wireguard'
export WIREGUARD_CONF="$WIREGUARD_DIR/wg0.conf"

mkdir -p "$WIREGUARD_DIR"
if ! chmod 700 "$WIREGUARD_DIR"; then
    echo 'Try again with sudo.' 1>&2
    exit 1
fi
