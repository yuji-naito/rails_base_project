
.DEFAULT_GOAL := help

up: ## Run Server
	docker compose up -d

down: ## Stop Server
	docker compose down --remove-orphans

restart: ## Restart Server
	@make down
	@make up

build: ## Build contaners
	docker compose build --no-cache --force-rm

install: ## Bundler install
	docker compose exec app bundle install

migrate: ## Migrate database
	docker compose exec app bundle exec rails db:migrate

init: ## initialize develoment
	docker compose up -d --build
	@make install
	docker compose exec app bundle exec rails db:create
	docker compose exec app bundle exec rails db:migrate
	docker compose exec app bundle exec rails db:seed

routes: ## Show routes
	docker compose exec app bundle exec rails routes

bash: ## Login Rails Container
	docker compose exec app bash

console: ## Run Rails console
	docker compose exec app bundle exec rails c

credentials: ## Edit credentials
	docker compose exec app bundle exec rails credentials:edit

credentials-staging: ## Edit credentials for staging
	docker compose exec app bundle exec rails credentials:edit --environment staging

credentials-production: ## Edit credentials for production
	docker compose exec app bundle exec rails credentials:edit --environment production

destroy: ## Destroy volumes and containers
	docker compose down --rmi all --volumes --remove-orphans

deploy-production: ## Deploy to Production
	bundle exec cap deploy

deploy-staging: ## Deploy to Staging
	BRANCH=develop bundle exec cap staging deploy

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
