container_file = ./srcs/docker-compose.yml
container_volume = /home/lvon-war/data

prep:
	@mkdir -p $(container_volume)/wordpress
	@mkdir -p $(container_volume)/mariadb

up: prep
	@docker compose -f $(container_file) up -d --build

down:
	@docker compose -f $(container_file) down

stop:
	@docker compose -f $(container_file) stop

clean:
	@docker compose -f $(container_file) down -v
	@docker system prune -f
	@rm -rf $(container_volume)

fclean: clean

re : clean up

status:
	@docker ps
	@docker volume ls

.PHONY: up down re clean