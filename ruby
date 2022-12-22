#!/bin/bash

docker run \
  --rm \
  --name rebase-labs \
  -w /app \
  -v $(pwd):/app \
  -v rubygems_rebase_labs:/usr/local/bundle \
  --network rebase-labs \
  -p 3000:3000 \
  ruby \
  bash -c "gem install bundler && bundle install" \