#!/bin/sh
/home/rubyuser/.rbenv/shims/bundle exec rake webpacker:compile
/home/rubyuser/.rbenv/shims/rake db:migrate
/home/rubyuser/.rbenv/shims/rails s -b 0.0.0.0
tail -f /dev/null


