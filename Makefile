.PHONY: all build deploy up down fclean re

all:	build deploy

# create-dirs:
# 	mkdir -p /Users/hkahsay/data/mariadb
# 	mkdir -p /Users/hkahsay/data/wordpress
build:
	docker-compose -f srcs/docker-compose.yml build

deploy:
	docker-compose -f srcs/docker-compose.yml up --detach

up:
	docker-compose -f srcs/docker-compose.yml up --detach --build

down:
	docker-compose -f srcs/docker-compose.yml down

fclean:
	# rm -rf /Users/hkahsay/data/wordpress/*
	# rm -rf /Users/hkahsay/data/mariadb/*
	docker stop $$(docker ps -qa); docker rm $$(docker ps -qa); docker rmi -f $$(docker images -qa); docker volume rm $$(docker volume ls -q); docker network rm $$(docker network ls -q) 2>/dev/null
	docker system prune -f

re: fclean all
