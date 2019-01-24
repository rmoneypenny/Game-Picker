require './lib/gamedb'


class Game

	def initialize
		@players = "yo" 
		@player = Player.create(name: "Randy")
	end

	def setup
		puts @players
		puts @player.name
	end

	def menu

	end

end



