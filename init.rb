
APP_ROOT = File.dirname(__FILE__)

require "#{APP_ROOT}/lib/game.rb"

#system("pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start")
game = Game.new
#game.setup

#system("pg_ctl -D /usr/local/var/postgres stop -s -m fast")