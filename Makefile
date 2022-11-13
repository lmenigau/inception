export COMPOSE_PROJECT_NAME=inception
export COMPOSE_FILE=srcs/compose.yaml
PWGEN = $(shell mktemp -u XXXXXXXXXXXXXXXXXXXXXX)
.PHONY: up re
DB=/home/lomeniga/data/db
WORDP=/home/lomeniga/data/wordp

up: srcs/.env srcs/cert.pem | $(DB) $(WORDP)
	docker compose up -d
down:
	docker compose down -t1

build:
	docker compose build

srcs/key.pem:
	openssl genrsa -out srcs/key.pem 2048
	chmod +r srcs/key.pem
srcs/cert.pem: srcs/key.pem
	openssl req -x509 -new -key srcs/key.pem -out srcs/cert.pem -days 365 -nodes -subj  '/CN=lomeniga.42.fr'

$(DB):
	mkdir -p $(DB)

$(WORDP):
	mkdir -p $(WORDP)

srcs/.env:
	(echo DB_PASSWD=$(PWGEN); echo WP_PWD=$(PWGEN)) > srcs/.env

wipe: down
	rm -rf /home/lomeniga/data/*

re: clean
	docker compose up
