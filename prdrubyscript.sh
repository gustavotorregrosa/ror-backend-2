#!/bin/sh
# sudo su
# /home/rubyuser/.rbenv/shims/bundle exec rake webpacker:compile
~/.rbenv/shims/rake db:migrate
~/.rbenv/shims/rails s -b 0.0.0.0
tail -f /dev/null


