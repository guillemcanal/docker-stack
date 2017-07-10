.PHONY: help build run clean

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build the Lagardere DNS Docker image
	@docker build -t lagardere/dnsmasq .

run: ## Start Traefik and your local DNS
	@docker network create traefik 2> /dev/null | true;
	@scripts/main before-enable
	@docker-compose up -d
	@scripts/main enable

clean: ## Remove Traefik and your local DNS
	@docker-compose down 2> /dev/null | true;
	@scripts/main disable
	@docker network rm traefik 2> /dev/null | true;
