ENV_PATH := 	srcs/.env
COMPOSE_PATH := srcs/docker-compose.yml

.PHONY: 		all hosts dirs build up down clean fclean re

all: 			hosts up

hosts:
				@set -a; . $(ENV_PATH); set +a; \
				if ! grep -q "$${DOMAIN_NAME}" /etc/hosts; then \
					sudo sh -c "echo '127.0.0.1 $${DOMAIN_NAME}' >> /etc/hosts"; \
					echo "Added $${DOMAIN_NAME} to /etc/hosts"; \
				fi

dirs:
				@set -a; . $(ENV_PATH); set +a; \
				mkdir -p $${DATA_PATH}/db $${DATA_PATH}/wp

build: 			dirs
				docker compose --env-file $(ENV_PATH) -f $(COMPOSE_PATH) build

up: 			build
				docker compose --env-file $(ENV_PATH) -f $(COMPOSE_PATH) up -d
				@echo "Infrastructure is up! Website: https://lkoc.42.fr"

down:
				docker compose --env-file $(ENV_PATH) -f $(COMPOSE_PATH) down

clean: 			down
				docker compose --env-file $(ENV_PATH) -f $(COMPOSE_PATH) down -v

fclean: 		clean
				@set -a; . $(ENV_PATH); set +a; \
				sudo rm -rf $${DATA_PATH}
				docker system prune -af

re: 			fclean all
