
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
		puts Game.where(name: "Power Grid").first.last_played
		self.menu
	end

	#main menu
	def menu
		endProgram = false
		while !endProgram
			puts "\n"*15
			puts "="*15
			puts "1. Pick a Game"
			puts "2. Current Game"
			puts "3. Enter Last Played Game"
			puts "4. Game List"
			puts "5. Exit"
			puts "="*15
			prompt = gets.strip.to_i
			case prompt
			when 1
				self.pickGameMenu
			when 2
				playerPick = Player.where(winner: true).first
				puts "#{playerPick.name} picked #{playerPick.picked_game}"
				gets
			when 3
				puts "Please enter game name"
				gameName = gets.strip
				lastPlayedGame = self.getGame(gameName)
				lastPlayedGame.last_played = Time.now+(60*60*7)
				lastPlayedGame.save
			when 4
				gameList = Game.all
				gameList.each do |g|
					if g.last_played
						puts "#{g.name} " + g.last_played.strftime("%m/%d/%Y")
					end
				end
				gets
			when 5
				puts "exit"
				endProgram = true
			end
		end
	end

	#get number of players and names
	def pickGameMenu
		players = []
		n = 0
		numberOfPlayersFlag = true
		puts "\n"*15
		while numberOfPlayersFlag do
			puts "How many players?"
			n = gets.strip.to_i
			(2..10).include?(n) ? (numberOfPlayersFlag = false) : (puts "Please enter a number between 1-10")
		end
		puts "Enter the player names:"
		n.times do
			name = gets.strip
			players << name
		end
		self.getPlayers(players)
		
	end

	#check databse for existing players and pull them or create new
	def getPlayers(players)
		playerRecords = []
		players.each do |p|
			Player.exists?(name: p) ? (playerRecords << Player.where(name: p).first) : (playerRecords <<Player.new(name: p, number: 1))
		end
		self.playerConfirmation(playerRecords)
	end

	#get number range for each player and ask for confirmation
	def playerConfirmation(playerRecords) 
		range = 0
		puts "\n"*15
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
		while true
			prompt = gets.strip.downcase
			if prompt == "yes" || prompt == "y"
				self.randomPlayer(playerRecords, range)
				break
			elsif prompt == "no" || prompt == "n"
				self.pickGameMenu
				break
			else
				puts "Please answer with yes or no"
			end
		end
	end

	#get a random player
	def randomPlayer(playerRecords, range)
		randomNumber = rand(1..range)
		playerNumber = 0
		playerRecords.each do |p|
			playerNumber += p.number
			if randomNumber <= playerNumber
				puts "#{randomNumber} - #{p.name}"
				gets
				self.winnersAndLosers(playerRecords, p)
				break
			end
		end
	end

	#separate the winners from the losers and adjust their numbers
	def winnersAndLosers(all, winner)
		puts "\n"*15
		puts "What game will be played?"
		gameName = gets.strip
		game = self.getGame(gameName)
		all.each do |a|
			if a == winner
				a.number = 1
				a.picked_game = game.name
				a.winner = true
				a.save	
			else
				a.number += 1
				a.winner = false
				a.save
			end
		end
		game.save
	end

	#get game chosen by winner
	def getGame(game)
		gameFlag = true
		while gameFlag
			puts "Is this correct?"
			if Game.exists?(name: game)
				g = Game.where(name: game).first
				puts g.name
			else
				g = Game.new(name: game)
				puts "!New! #{g.name}"
			end
			prompt = gets.strip.downcase
			if prompt == "yes" || prompt == "y"
				gameFlag = false
			elsif prompt == "no" || prompt == "n"
				puts "What game is the game name?"
				game = gets.strip
			else
				puts "Please answer with yes or no"
			end					
		end
		g
	end


end

	

