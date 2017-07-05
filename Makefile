.PHONY: help build run clean show

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build the Lagardere DNS Docker image
	@docker build -t lagardere/dnsmasq .

run: ## Start Traefik and your local DNS
	@docker network create traefik 2> /dev/null | true;
	@docker-compose up -d
	@scripts/dns-switch enable

clean: ## Remove Traefik and your local DNS
	@docker-compose down
	@scripts/dns-switch disable
	@docker network rm traefik 2> /dev/null | true;

show: ## Show Network Interface Informations
	@scripts/dns-switch show
