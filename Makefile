.PHONY: help run clean

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: ## Start Traefik and your local DNS
	@echo "[info] cleaning your docker stack"
	@echo " ---> create the docker traefik network"
	@docker network create traefik 2> /dev/null | true;
	@echo " ---> prepare local network"
	@scripts/network before
	@echo " ---> start docker containers"
	@docker-compose up -d
	@echo " ---> enable local network"
	@scripts/network enable
	@echo " ---> installing the root certificate"
	@scripts/network install-ca
	@echo
	@echo "------------------------------"
	@echo "redémarrez vos navigateurs web"
	@echo "------------------------------"

clean: ## Remove Traefik and your local DNS
	@echo "[info] cleaning your docker stack"
	@echo " ---> removing docker containers"
	@docker-compose down 2> /dev/null | true;
	@echo " ---> disable the local DNS server"
	@scripts/network disable
	@echo " ---> remove the docker traefik network"
	@docker network rm traefik 2> /dev/null | true;
