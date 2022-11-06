export COMPOSE_PROJECT_NAME=inception
export COMPOSE_FILE=srcs/compose.yaml
PWGEN = $(shell mktemp -u XXXXXXXXXXXXXXXXXXXXXX)
.PHONY: up re

up: srcs/.env
	docker compose up --build -d

srcs/.env:
	(echo DB_PASSWD=$(PWGEN); echo WP_PWD=$(PWGEN)) > srcs/.env

clean:
	docker compose rm -sf && docker volume rm -f inception_db inception_wordpress

re: clean
	docker compose up -d --build --force-recreate
