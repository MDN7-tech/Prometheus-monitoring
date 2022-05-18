#!/usr/bin/env make

CONTAINER=prometheus
# CONTAINER=grafana
# CONTAINER=alertmanager

all: update restart logs

init:
	@echo "===== Initialize ====="
	cp -n .env.example .env
	mkdir ./monitoring/prometheus/data
	mkdir ./monitoring/alertmanager/data
	mkdir -p ./monitoring/grafana/data
	sudo chown 1011:1011 ./monitoring/prometheus/ -R
	sudo chown 1012:1012 ./monitoring/alertmanager/ -R
	sudo chown 1013:1013 ./monitoring/grafana/ -R
	nano .env
	cp -n .env ./masenger/telegram/

build: .env
	@echo "===== Docker build ====="
	docker-compose build --compress --parallel

up: .env
	@echo "===== Docker up ====="
	docker-compose up

down: .env
	@echo "===== Docker down ====="
	docker-compose down --remove-orphans

start: .env
	@echo "===== Docker start ====="
	docker-compose up -d

stop: .env
	@echo "===== Docker stop ====="
	docker-compose stop

restart: .env
	@echo "===== Docker restart ====="
	make down
	make start

remove: stop
	@echo "===== Remove containers ====="
	docker-compose rm -f

logs: .env
	@echo "===== Docker logs ====="
	docker-compose logs -f

run: .env
	@echo "===== Docker run container ====="
	docker-compose run --rm ${CONTAINER} bash

exec: .env
	@echo "===== Docker exec container ====="
	docker-compose run --rm ${CONTAINER} bash

stats:
	@echo "===== Docker stats ====="
	docker stats

ps:
	@echo "===== Print state of containers ====="
	docker-compose ps

update:
	@echo "===== Git Update ====="
	git pull
reload: .env
	curl -i -XPOST -u lf-prometheus:${RELATED_PASSWORD} localhost:9090/-/reload