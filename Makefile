NAME = inception

all: build up

build:
	mkdir -p ~/data/wordpress/
	mkdir -p ~/data/mariadb
	docker-compose -f ./srcs/docker-compose.yml build

up:
	docker-compose -f ./srcs/docker-compose.yml up -d
down:
	docker-compose -f ./srcs/docker-compose.yml down

re: down
	docker-compose -f ./srcs/docker-compose.yml -d --build

clean: down
	docker system prune -a
	sudo rm -rf ~/data/wordpress/
	sudo rm -rf ~/data/mariadb/

fclean: down
	docker image rm -f $$(docker image ls -q)
	docker volume rm $$(docker volume ls -q)
	sudo rm -rf ~/data/wordpress/*
	sudo rm -rf ~/data/mariadb/*

.PHONY	: all build down re clean fclean
