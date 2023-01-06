server:
	@docker compose run \
	--name rebase-labs \
	--rm \
	--service-ports \
	app \
	--network rebase-labs \
	bash -c "ruby server.rb"

bundle:
	@docker compose run app bundle \

this-rspec:
	@docker container exec \
	-it rebase-labs \
	bash -c "rspec" \

sidekiq:	
	@docker container exec \
	-it rebase-labs \
	bash -c "sidekiq -r ./app/jobs/*" \
