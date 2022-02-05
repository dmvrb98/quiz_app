LOCAL_ENV := local
DEV_ENV := dev
PROD_ENV := prod

DOCKER_COMPOSE = `which docker-compose`

APP = app

ifneq ($(filter $(env),$(STAGE_ENV) $(PROD_ENV)),)
	DOCKERCOMPOSE_PATH := docker-compose.prod.yml
else
	DOCKERCOMPOSE_PATH := docker-compose.yml
endif

help: ## Display this help message
	  @echo "Please use \`make <target>' where <target> is one of"
	  @perl -nle'print $& if m{^[\.a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'

sh: ## sh into backend app container
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) exec $(APP) bash

collectstatic: ## collect app static
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) exec $(APP) poetry run python manage.py collectstatic --noinput

migrate: ## migrate backend app
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) exec $(APP) poetry run python manage.py migrate

makemigrations: ## makemigrations for backend app
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) exec $(APP) poetry run python manage.py makemigrations

up: ## Run all containers
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) up -d

down: ## Run all containers
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) down

restart: ## Restart all containers
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) restart

stop: ## Stop all containers
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) stop

rm: ## Remove all containers
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) rm

debug: ## Debug backend app
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) run -T --service-ports $(APP)

build: ## Build all images
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) build

rebuid: ## Rebuild images and run containers
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) up --build -d

rebuid_app: ## Rebuild backend app
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) build $(APP)

test: ## Run tests for the app
	$(DOCKER_COMPOSE) -f $(DOCKERCOMPOSE_PATH) run --rm $(APP) \
		bash -c \
		" \
		find . | grep -E \"(__pycache__|\.pyc|\.pyo$\)\" | xargs rm -rf && \
		pytest -s && \
		coverage xml && \
		diff-cover coverage.xml --fail-under=60 \
		"
