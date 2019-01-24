
APP_ROOT = File.dirname(__FILE__)

require "#{APP_ROOT}/lib/game.rb"

game = Game.new
game.setup
