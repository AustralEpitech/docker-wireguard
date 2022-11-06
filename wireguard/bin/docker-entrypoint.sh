#!/bin/bash
. "$(dirname "$0")/lib.sh"

function get_local_ip4() {
    ip -4 route get 1 | grep -oP '(\d{1,3}\.){3}\d{1,3}(?= uid)'
}

create_default_conf

ip address add dev wg0 '10.0.0.0'
wg setconf wg0 "$WIREGUARD_CONF"
ip link set up dev wg0

exec "$@"
