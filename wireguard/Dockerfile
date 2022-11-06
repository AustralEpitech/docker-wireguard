FROM debian
EXPOSE 443
VOLUME /etc/wireguard/
RUN apt-get update && apt-get install -y \
        iproute2                         \
        wireguard-tools &&               \
    apt-get clean &&                     \
    rm -rf /var/lib/apt/
COPY bin/ /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sleep", "infinity"]
