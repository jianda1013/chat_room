DC=docker-compose
SV=server

ifeq ($(OS),Windows_NT)     # is Windows_NT on XP, 2000, 7, Vista, 10...
    detected_OS := Windows
else
    detected_OS := $(shell uname)  # same as "uname -s"
endif

test:
	echo ${detected_OS}

mac:
	@export LC_CTYPE=C

init: ## Init the project after a git clone
	@echo "INIT PROJECT"
	@echo "Copying .env.dist in .env"
	@cp .env.dist .env
	@if [ ${detected_OS} = "Darwin" ]; then\
		export LC_CTYPE=C;\
    	sed -i "" "s@SECRET_TO_CHANGE@`tr -dc A-Za-z0-9_ < /dev/urandom | head -c 64 | xargs`@g" .env;\
	elif [ ${detected_OS} = "Linux" ]; then\
    	sed -i "s@SECRET_TO_CHANGE@`tr -dc A-Za-z0-9_ < /dev/urandom | head -c 64 | xargs`@g" .env;\
	else\
		echo "WINDOWS SYSTEM PLEASE COPY .env.dist TO .env AND SET VARIABLE";\
	fi
	@echo "\n.env:"
	@cat .env
	@echo "\n"

start: ## Build and launch the project in background
	@echo "Check .env File Exist"
	@if [ ! -f "$(pwd)/.env" ]; then\
		$(MAKE) init;\
	fi
	@echo "Launch dettached projet and build\n"
	$(DC) up -d --build

clean: ## Stop and delete the project stack
	$(DC) down

logs: ## Attach to standard output of containers
	$(DC) -f docker-compose.yml logs -f $(SV)

re: clean start

exec: ## Execute command inside server container
	$(DC) exec $(SV) sh