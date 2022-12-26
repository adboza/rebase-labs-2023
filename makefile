server:
	@docker compose run \
	--name rebase-labs \
	--rm \
	--service-ports \
	app \
	--network rebase-labs 
	bash -c "ruby server.rb"

bundle:
	@docker compose run app bundle \

rspec:
	@docker compose run rspec \
