.PHONY: help run clean

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: ## Start Traefik and your local DNS
	@docker network create traefik 2> /dev/null | true;
	@scripts/main before-enable
	@docker-compose up -d
	@scripts/main enable

clean: ## Remove Traefik and your local DNS
	@echo "[info] cleaning your docker stack"
	@echo "---> remove docker containers"
	@docker-compose down 2> /dev/null | true;
	@echo "---> disable the local DNS server"
	@scripts/main disable
	@echo "---> remove the docker traefik network"
	@docker network rm traefik 2> /dev/null | true;
