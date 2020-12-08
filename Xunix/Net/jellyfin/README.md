# Deploy jellyfin by Docker #
[Ref](https://jellyfin.org/docs/general/administration/installing.html#docker)
## Pre-requirement ##
**Docker please**
(Docker-Compose is optional)

## Installation ##

1. Download the latest container's image:
    `docker pull jellyfin/jellyfin`
2. Create persisitent storage for configuration and cache file
   `docker volumes create jellyfin-config`
   `docker volumes create jellyfin-cache`
   or create two directories on the host and use bind mounts:(Recommend)
   `mkdir /path/to/config`
   `mkdir /path/to/cache`
3. Create container and run !
    
    ```bash
    docker run -d \
    --name jellyfin \
    --user uid:gid \
    --volume /path/to/config:/config \
    --volume /path/to/cache:/cache \
    --mount type=bind,source=/path/to/media,target=/media \
    --restart=unless-stopped \
    jellyfin/jellyfin
    ```
    multiple media libraries can be bind mounted if needed:
    ```
    --mount type=bind,source=/path/to/media1,target=/media1
    --mount type=bind,source=/path/to/media2,target=/media2,readonly
    ...etc
    ```
4. Open browser and type `https://IP:8096`

## Update ##
1. Just keep mapping the `/config` and `/cache` directory from the old ones on your host machine.


## Docker-Compose ##
1. Create a file named docker-compose.yml as follow:   
   ```yml
    version: "3.8"
    services:
      jellyfin:
        image: jellyfin/jellyfin
        container_name: jellyfin
        user: 1000:1000
        network_mode: "host"
        volumes:
          - /srv/jellyfin/config:/config
          - /srv/jellyfin/cache:/cache
          - /home/sonnet/media:/media
        restart: "unless-stopped"
    ```
2. run `docker-compose up -d`


