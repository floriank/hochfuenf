UID := $(shell id -u)
GID := $(shell id -g)
DEV_CONFIG_FILE = config/dev.exs
dc=docker compose -f docker-compose.yml $(1)
dc-run=$(call dc, run --rm dev $(1))
mix-dev=$(call dc-run, mix do $(1) MIX_ENV=dev)
mix-test=$(call dc-run, mix do $(1) MIX_ENV=test)
comma:= ,

usage:
	@echo "Available targets:"
	@echo "  * setup            - Initiate everything (build images, install dependencies)"
	@echo "  * dev-config       - Copy dev config from config/dev.exs.sample"
	@echo "  * build            - Build image"
	@echo "  * hex-deps         - Install missing hex dependencies"
	@echo "  * setup-test       - Initiate everything needed for running the tests, e.g. in CI"
	@echo "  * shell            - Fire up a shell inside of your container"
	@echo "  * iex              - Fire up a iex console inside of your container"
	@echo "  * format           - Run the Elixir code formatter"
	@echo "  * check-formatted  - Check whether all Elixir code is formatted"
	@echo "  * clean            - Cleanup files [destructive]"
	@echo "  * up               - Run the development server"
	@echo "  * down             - Remove containers and tear down the setup"
	@echo "  * stop             - Stop the development server"
	@echo "  * status           - see the current status of the development server"
	@echo "  * test             - Run tests"
	@echo "  * test-watch       - Observe files and run tests on changes"
	@echo "  * reset       		- Reset the development server"
	@echo "  * reset-hard       - Rebuild all the things, restart"


.PHONY: test

setup: dev-config build hex-deps db

reset: stop up

reset-hard: down setup up

clean:
	rm -rf config/dev.exs config/prod.exs .envrc .env

dev-config:
	@cp -n config/dev.exs.sample config/dev.exs
	@cp -n .env.example .env
	@cp -n .envrc.example .envrc
	rsync --ignore-existing config/dev.exs.sample config/dev.exs
build:
	$(call dc, build)
hex-deps:
	USER_ID=$(UID) GROUP_ID=$(GID) $(call mix-dev, deps.get)
shell:
	USER_ID=$(UID) GROUP_ID=$(GID) $(call dc-run, bash)
iex:
	USER_ID=$(UID) GROUP_ID=$(GID) $(call dc-run, iex -S mix)
format:
	$(call dc-run, mix format)
check-formatted:
	$(call dc-run, mix format --check-formatted)
up:
	$(call dc, up -d)
	@echo "Development server running, check with 'make status'"
down:
	$(call dc, down)
stop:
	$(call dc, stop)
status:
	$(call dc, ps)
test:
	$(call dc-run, mix test)
test-watch:
	$(call dc-run, mix test.watch)
db:
	$(call dc-run, mix do ecto.setup + ecto.migrate)
