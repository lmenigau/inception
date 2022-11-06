COMPOSE_PROJECT_NAME=inception
PWGEN = $(shell mktemp -u XXXXXXXXXXXXXXXXXXXXXX)
.PHONY: all re

all: srcs/.env
	cd srcs && docker compose up

.env:
	(echo DB_PASSWD=$(PWGEN); echo WP_PWD=$(PWGEN)) > .env

clean:
	docker compose rm -f

re: all
	rm srcs/.env
