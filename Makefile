export COMPOSE_PROJECT_NAME=inception
export COMPOSE_FILE=srcs/compose.yaml
PWGEN = $(shell mktemp -u XXXXXXXXXXXXXXXXXXXXXX)
.PHONY: up re
DB=/home/lomeniga/data/db
WORDP=/home/lomeniga/data/wordp

up: srcs/.env srcs/cert.pem | $(DB) $(WORDP)
	docker compose up

srcs/cert.pem:
	openssl req -x509 -newkey rsa:4096 -keyout srcs/key.pem -out srcs/cert.pem -sha256 -days 365 -nodes -subj  '/CN=lomeniga.42.fr'

$(DB):
	mkdir -p $(DB)

$(WORDP):
	mkdir -p $(WORDP)

srcs/.env: 
	(echo DB_PASSWD=$(PWGEN); echo WP_PWD=$(PWGEN)) > srcs/.env

clean:  
	docker compose down -t1
	rm -rf /home/lomeniga/data/*

re: clean
	docker compose up 
