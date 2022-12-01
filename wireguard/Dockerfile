FROM debian:11-slim
RUN apt-get update && apt-get install -y \
        iproute2                         \
        iptables                         \
        openresolv                       \
        wireguard-tools &&               \
    apt-get clean &&                     \
    rm -rf /var/lib/apt/
VOLUME /etc/wireguard/
COPY bin/ /usr/local/bin/
COPY wg0.conf /etc/wireguard/wg0.conf
EXPOSE 443/udp
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sleep", "infinity"]
