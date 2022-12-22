#!/bin/bash

docker run \
  --rm \
  --name rebase-labs \
  -w /app \
  -v $(pwd):/app \
  --network rebase-labs \
  -p 3000:3000 \
  ruby \
  bash -c "gem install bundler && bundle install && ruby import_from_csv.rb"