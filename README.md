# docker-wireguard

## Quick start
Add missing fields in .env for both server and client


### Server side
```console
docker-compose up -d --build
```

#### Add a peer
```console
docker exec -it wireguard add-peer.sh
```

### Client side
```console
# ./install.sh
```
