COMPOSE_PROJECT_NAME=inception
PWGEN = $(shell mktemp -u XXXXXXXXXXXXXXXXXXXXXX)
.PHONY: all
all: srcs/.env
	cd srcs && docker compose up

.env:
	(echo DB_PASSWD=$(PWGEN); echo WP_PWD=$(PWGEN)) > .env
re:
	docker compose
