export COMPOSE_PROJECT_NAME=inception
export COMPOSE_FILE=srcs/compose.yaml
PWGEN = $(shell mktemp -u XXXXXXXXXXXXXXXXXXXXXX)
.PHONY: up re

up: srcs/.env
	docker compose up --build

srcs/.env:
	(echo DB_PASSWD=$(PWGEN); echo WP_PWD=$(PWGEN)) > srcs/.env

clean:
	docker compose down -t 0 --remove-orphans --rmi all
	docker compose run --rm mariadb sh -c "rm -rf /var/lib/mysql/*"
	docker compose run --rm --entrypoint 'sh -c "rm -rf /wordpress/*"' wordpress
	docker volume rm -f inception_db inception_db

re: clean
	docker compose up -d --build --force-recreate
