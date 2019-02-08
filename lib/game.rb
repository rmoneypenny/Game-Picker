
 require 'active_record'
 require_relative './app/models/Player'
 require_relative './app/models/Game'
 require 'gtk3'

 def db_configuration
   db_configuration_file = File.join(File.expand_path('..', __FILE__), 'db', 'config.yml')
   YAML.load(File.read(db_configuration_file))
 end
 
 ActiveRecord::Base.establish_connection(db_configuration["development"])


class GamePick


	def initialize
		# @player = Player.create(name: "Randy", number: 2, picked_game: "test")
		# @player = Player.create(name: "Tausha", number: 2, picked_game: "test")
		# @player = Player.create(name: "Ashley", number: 2)
		# puts Player.all.count
		# puts @players
		# @game = Game.create(name: "Test")
		# @game2 = Game.create(name: "Test2")
		# @game3 = Game.create(name: "Test")
		# @games = Game.all.destroy_all
		# puts Game.all.count
		
	end


	def setup
		self.menu
	end

	def menu
		endProgram = false
		while !endProgram
			puts "\n"*15
			puts "="*15
			puts "1. Pick a Game"
			puts "2. Game List"
			puts "3. Game History"
			puts "4. Exit"
			puts "="*15
			prompt = gets.strip.to_i
			case prompt
			when 1
				self.pickGameMenu
			when 2
				puts "list"
				gets
			when 3
				puts "history"
				gets
			when 4
				puts "exit"
				endProgram = true
			end
		end
	end

	def pickGameMenu
		players = []
		puts "How many players?"
		n = gets.strip.to_i
		puts "Enter the player names:"
		n.times do
			name = gets.strip
			players << name
		end
		self.getPlayers(players)
		
	end

	def getPlayers(players)
		playerRecords = []
		players.each do |p|
			Player.exists?(name: p) ? (playerRecords << Player.where(name: p).first) : (playerRecords <<Player.new(name: p, number: 1))
		end
		self.playerConfirmation(playerRecords)
	end

	def playerConfirmation(playerRecords) 
		range = 0
		puts "Is this correct?"
		playerRecords.each do |p|
			existingRecord = true
			beginRange = range + 1
			endRange = range + p.number
			range += p.number
			Player.exists?(name: p.name) ? (nil) : (existingRecord = false)
			if beginRange == endRange
				puts "#{beginRange} : #{existingRecord ? ("") : ("!NEW! Player:")} #{p.name}"
			else
				puts "#{beginRange}-#{endRange} : #{p.name}"
			end			
		end
		prompt = gets.strip.downcase
		if prompt == "yes" || prompt == "y"
			puts "yes!"
		elsif prompt == "no" || prompt == "n"
			puts "no!"
		else
			puts "Please answer with yes or no"
		end
	end

end

	

