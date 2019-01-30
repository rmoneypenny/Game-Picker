
 require 'active_record'
 require_relative './app/models/player'
 
 def db_configuration
   db_configuration_file = File.join(File.expand_path('..', __FILE__), 'db', 'config.yml')
   YAML.load(File.read(db_configuration_file))
 end
 
 ActiveRecord::Base.establish_connection(db_configuration["development"])


class Game

	def initialize
		#@player = Player.create(name: "Randy", number: 2, picked_game: "test")
		#@player = Player.create(name: "Randy", number: 2, picked_game: "test")
		#@players = Player.where(name: "Randy").destroy_all
		#puts Player.all.count
		#puts @players

	end

	# def setup
	# 	puts @players
	# 	puts @player.name
	# end

	# def menu

	# end

	def menu
		
	end

end



