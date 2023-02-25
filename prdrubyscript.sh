#!/bin/sh
yarn install
/home/rubyuser/.rbenv/shims/gem install bundler
/home/rubyuser/.rbenv/shims/bundle install
# bash -l -c 'source set_env.sh'
/home/rubyuser/.rbenv/shims/rake db:migrate
/home/rubyuser/.rbenv/bin/rbenv rehash
/home/rubyuser/.rbenv/shims/bundle exec rake webpacker:compile
/home/rubyuser/.rbenv/shims/rails s -b 0.0.0.0
tail -f /dev/null


