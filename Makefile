export COMPOSE_PROJECT_NAME=inception
export COMPOSE_FILE=srcs/compose.yaml
PWGEN = $(shell mktemp -u XXXXXXXXXXXXXXXXXXXXXX)
.PHONY: up re
DB=/home/lomeniga/data/db
WORDP=/home/lomeniga/data/wordp

up: srcs/.env srcs/cert.pem | $(DB) $(WORDP)
	docker compose up -d
stop:
	docker compose stop 

down:
	docker compose down 

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

.ONESHELL:
srcs/.env:
	cat << EOF > srcs/.env
	DB_PASSWD=$(PWGEN)
	WP_PWD=$(PWGEN)
	ROOT_PWD=$(PWGEN)
	EOF

wipe: down
	rm -rf /home/lomeniga/data/*

re: clean
	docker compose up
