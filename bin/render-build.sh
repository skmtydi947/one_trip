#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rails webpacker:install
bundle exec rails webpacker:compile
bundle exec rake db:migrate