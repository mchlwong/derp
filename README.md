# About this repo
Tailscale custom DERP server Dockerfile and configs.

# Docker command
```shell
docker run -d \
--name derp \
--restart=always \
-e DERP_DOMAIN=your.domain.name \
-p 10443:443 \
-p 3478:3478/tcp \
-p 3478:3478/udp \
-v /etc/letsencrypt/live/your.domain.name/fullchain.pem:/cert/your.domain.name.crt \
-v /etc/letsencrypt/live/your.domain.name/privkey.pem:/cert/your.domain.name.key \
derp:latest
```

# Tailscale admin ACLs
```json
"derpMap": {
  "OmitDefaultRegions": true,
  "Regions": { "900": {
    "RegionID": 900,
    "RegionCode": "myderp",
    "Nodes": [{
        "Name": "1",
        "RegionID": 900,
        "HostName": "your.domain.name",
        "DERPPort": 10443
    }]
  }}
}
```
