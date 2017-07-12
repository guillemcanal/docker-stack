# Docker Development Stack

**🎊 Access your Docker containers from a domain name using HTTP or HTTPS 🎊**

This project provide :

- a **DNS server** ([Dnsmasq](https://wiki.debian.org/HowTo/dnsmasq) with [regex support](https://github.com/cuckoohello/dnsmasq-regex)),
- an **HTTP reverse proxy** ([Træfɪk](https://traefik.io)),
- and a **Watcher** that listen to started containers in order to generate TLS certificates.

![spack.svg](./stack.png)

## Requirements

- [Docker](https://docs.docker.com/engine/installation/) 
- [Docker Compose](https://docs.docker.com/compose/install/).

## Usage

Simple and easy :

```bash
make run
```

You should be able to access:

- The Traefik FrontEnd on <http://127.0.0.1:80> (you should see `404 page not found`)
- The Traefik Web UI on <http://127.0.0.1:8080>
- A Local DNS Web UI on <http://127.0.0.1:8053>
- A Key/Value store Web UI on <http://127.0.0.1:8500>

### For Windows users

Please read [this (in french)](docs/windows.md)

## Test your stack

There is a `docker-compose.yml` example located 
in  `./examples/docker-compose.yml`, please read it carefully.

From your project root execute :

```bash
docker-compose -f example/docker-compose.yml up
```

> **Note**: <kdb>Ctrl+C</kdb> to exit

Open your browser on <http://dev.domain.fr>

## HTTPS support

The stack generate a root certificate in `/data/ssl/rootCA.pem`.  
You will need to install it on your browser and/or operating system 

Here is [a very good guide](https://www.bounca.org/tutorials/install_root_certificate.html) about how to do it

Once done, you will be able to access your container using **HTTPS**.  
All you need to do is to add the following labels (see `./example/docker-compose.yml` for a working example) :

- `ssl.domain`: The main domain for your Docker container (ex: `dev.company.fr`)
- `ssl.domain.alt_names` : A coma separated list of alternatives domains names for your Docker containers (ex: `dev.company.fr,dev.admin.company.fr`)

## Customize

By default, the local DNS server is configured to resolve every domains starting with `dev.` to your local IP address.

You can change that by modifying the `address` intruction in <http://localhost:8053>

You can modify the exist `address` instruction or add additionnal addresses.

Examples :

```ini
# A regex (must be wrapped between colons), that match domain starting with "dev."
address=/:^dev\.:/127.0.0.1

# A standard rule that match domain ending with ".docker"
address=/.docker/127.0.0.1

# A regex that match domains starting with "test." and ending with "domain.fr"
address=/:^test\..+domain.fr$:/127.0.0.1
```

Once done, click on **Save**, it will restart automatically