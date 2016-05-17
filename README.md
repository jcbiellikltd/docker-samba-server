# Samba server
[![Docker Pulls](https://img.shields.io/docker/pulls/joebiellik/samba-server.svg)](https://hub.docker.com/r/joebiellik/samba-server/)

[Samba 4](https://www.samba.org/) server running under [s6 overlay](https://github.com/just-containers/s6-overlay) on [Alpine Linux](https://hub.docker.com/_/alpine/). Runs both `smbd` and `nmbd` services.

## Configuration
See [example directory](https://github.com/jcbiellikltd/docker-samba-server/tree/master/example) for sample config file.

## Quickstart
```
samba:
  image: joebiellik/samba-server

  volumes:
    # You must provide a Samba config file
    - ./smb.conf:/config/smb.conf

    # Shares
    - ~/projects:/mnt/projects
    - ~/videos:/mnt/videos:ro

  ports:
    - "137:137/udp"
    - "138:138/udp"
    - "139:139/tcp"
    - "445:445/tcp"

  environment:
    - USERNAME=joe
    - PASSWORD=samba
```
