container_file = ./srcs/docker-compose.yml

up:
	@docker compose -f $(container_file) up -d --build

down:
	@docker compose -f $(container_file) down

stop:
	@docker compose -f $(container_file) stop

clean:
	@docker compose -f $(container_file) down -v
	@docker system prune -f

fclean: clean

re : clean up

status:
	@docker ps
	@docker volume ls

.PHONY: up down re clean