FROM debian
EXPOSE 443
VOLUME /etc/wireguard/
RUN apt-get update && apt-get install -y \
        iproute2                         \
        iptables                         \
        wireguard-tools &&               \
    apt-get clean &&                     \
    rm -rf /var/lib/apt/
COPY bin/ /usr/local/bin/
COPY wg0.conf /etc/wireguard/wg0.conf
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sleep", "infinity"]
