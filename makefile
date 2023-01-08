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

seed-db:	
	@docker container exec \
	-it rebase-labs \
	bash -c "ruby import_from_csv.rb" \
