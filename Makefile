
all:
		sudo mkdir -p $(HOME)/data/wordpress
		sudo mkdir -p $(HOME)/data/mariadb
		docker compose -f srcs/docker-compose.yml up --detach --build

# create-dirs:
# 	mkdir -p /Users/hkahsay/data/mariadb
# 	mkdir -p /Users/hkahsay/data/wordpress

up:
		docker compose -f srcs/docker-compose.yml up --detach

stop:
		docker compose -f srcs/docker-compose.yml stop 

down:
		docker compose -f srcs/docker-compose.yml down

clean:	down

		docker system prune -af

fclean: clean
		sudo rm -rf $(HOME)/data
		# rm -rf /Users/hkahsay/data/wordpress

		# docker stop $$(docker ps -qa); docker rm $$(docker ps -qa); docker rmi -f $$(docker images -qa); docker volume rm $$(docker volume ls -q); docker network rm $$(docker network ls -q) 2>/dev/null
		# docker system prune -f

re: fclean all

.PHONY: all up stop down clean fclean re

