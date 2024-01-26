.PHONY: all build deploy

all: build deploy

build:
	docker compose -f srcs/docker-compose.yml build 

deploy:
	docker compose srcs/docker-compose.yml up -d