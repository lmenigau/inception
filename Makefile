export COMPOSE_PROJECT_NAME=inception
export COMPOSE_FILE=srcs/compose.yaml
PWGEN = $(shell mktemp -u XXXXXXXXXXXXXXXXXXXXXX)
.PHONY: up re
DB=/home/lomeniga/data/db
WORDP=/home/lomeniga/data/wordp

up: srcs/.env | $(DB) $(WORDP)
	docker compose up

$(DB):
	mkdir -p $(DB)

$(WORDP):
	mkdir -p $(WORDP)

srcs/.env: 
	mkdir $(DB) $(WORDP)
	(echo DB_PASSWD=$(PWGEN); echo WP_PWD=$(PWGEN)) > srcs/.env

clean:  
	docker compose down -t1
	rm -rf /home/lomeniga/data/*

re: clean
	docker compose up 
