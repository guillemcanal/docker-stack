# Docker Development Stack

**Access your Docker containers with a domain name 🎉**

This little project provide a DNS server ([Dnsmasq](https://wiki.debian.org/HowTo/dnsmasq) with [regex support](https://github.com/cuckoohello/dnsmasq-regex)) and a reverse proxy ([Træfɪk](https://traefik.io))

![spack.svg](./stack.png)

## Requirements

- A linux distro with [NetworkManager](https://wiki.gnome.org/Projects/NetworkManager) (Ubuntu, Debian, Fedora, CentOS, ArchLinux ...)
- [Docker](https://docs.docker.com/engine/installation/) 
- [Docker Compose](https://docs.docker.com/compose/install/).

Quick Docker installation instructions : 

```bash
# Install docker
curl -fsSL https://get.docker.com/ | sh
# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
# Allow your current user to access the docker binary
sudo usermod -aG docker $USER
```

Log in and out from your Linux session

## Installation

```bash
# build the local DNS image (dnsmasq)
make build
# run the local DNS
make run
```

You should be able to access:

- The traefik FrontEnd on <http://127.0.0.1> (you should see `404 page not found`)
- The traefik Web UI on <http://127.0.0.1:8080>
- The dnsmasq Web UI on <http://127.0.0.1:8053>

**If something goes wrong, read the [troubleshoot](#troubleshoot) section**

## Test your stack

Please see the  `./examples` folder for a `docker-compose` example.

Let's run a Docker container using Træfɪk labels 
allowing us to use `dev.test.europe1.fr` as domain name 

```bash
docker run --rm --net traefik \
-l "traefik.enable=true" \
-l "traefik.backend=test" \
-l "traefik.frontend.rule=Host: dev.test.europe1.fr" \
emilevauge/whoami
```

When running `curl dev.test.europe1.fr` you should see something like this :

```http
Hostname: 2fcc2fbe70ab
IP: 127.0.0.1
IP: ::1
IP: 172.19.0.5
IP: fe80::42:acff:fe13:5
GET / HTTP/1.1
Host: dev.test.europe1.fr
User-Agent: curl/7.47.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 172.19.0.1
X-Forwarded-Host: dev.test.europe1.fr
X-Forwarded-Proto: http
X-Forwarded-Server: 6409f34eac5e
```

> If you want to know more, RTFM of Træfɪk right [here](https://docs.traefik.io/)

## Troubleshoot

- **When running `docker-compose`, it say that port `80` and/or `8080` and/or `8053` is/are already allocated**

	Ports `53`, `80`, `8080` and `8053` are needed by Traefik and Dnsmasq.  
	Please shutdown any services using those ports.  
	If you are not sure how, please **ask a colleague**

- **I'm using Docker Toolbox and it won't work**

	Docker Toolbox is running Docker inside a fat VM (such as VirtualBox and the like).  
	So your DNS server and Traefik proxy won't be running on `127.0.0.1`.

	Instead, you should use the private ip of your VM using the `docker-machine` command :
	`docker-machine ip default`.

	In `dnsmasq.conf` replace `127.0.0.1` with the ip of your docker machine,  
	and when setting up your DNS on your host, be sure to use your docker-machine ip address instead of `127.0.0.1`