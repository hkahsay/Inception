.PHONY: all build deploy

all: build deploy

build:
	docker-compose build

deploy:
	docker-compose-c up -d