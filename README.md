# Custom Tailscale DERP container

## Intro

When using Tailscale to connect your stuff, chances are you have run into issues, where a direct connection cannot be established, and using the normal DERP serveres result in high latency.

Tailscale allows custom, local DERP servers, that can help overcome those issues. More info here: [Custom DERP Servers - Tailscale](https://tailscale.com/kb/1118/custom-derp-servers/).

This is simply a dockerized version of the custom Tailscale `derper` daemon.

## Preparation

Make sure you have a DNS name such as `derp.example.com` set up, and pointed to your server.

Your firewall should allow the following ports:

- 443/tcp
- 3478/udp

## Setup

This docker-compose file can be used to run a custom DERP server.

_**Remember:** change the value of the `DERP_DOMAIN` env variable to your own DNS name._

```
services:
  derper:
    image: tmuncks/derper:latest
    restart: always
    environment:
      DERP_DOMAIN: derp.example.com
    volumes:
      - ./derper-certs:/root/.cache/tailscale/derper-certs
    ports:
    - "443:443/tcp"
    - "3478:3478/udp"
```

Then just start it:

```
docker-compose up -d
```

Check that you can access your server at (https://derp.example.com).

## Configure

To start using the custom DERP server, add it to the ACL in Tailscale:

_**Remember:** change at least the `HostName` value to match your DNS name._


```
// Custom DERP nodes
"derpMap": {
	"OmitDefaultRegions": true,
	"Regions": {
		"900": {
			"RegionID":   900,
			"RegionCode": "myd",
			"RegionName": "My Custom DERP",
			"Nodes": [
				{
					"Name":     "1a",
					"RegionID": 900,
					"HostName": "derp.example.com",
				},
			],
		},
	},
},
```
