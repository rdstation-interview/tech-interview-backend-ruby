env-exists:
ifeq (,$(wildcard ./.env))
	    cp .env.example .env
endif

build: env-exists
	docker-compose build
start: env-exists
	docker-compose up
bash: env-exists
	docker-compose run web bash
specs: env-exists
	docker-compose run bundle exec rspec specs