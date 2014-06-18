class Game
	def initialize(players)
		@players = players
		@is_last_round = false
	end

	def start_game()
		@players.each do |player|
			puts "Player #{player.player_no + 1}\'s turn"
			player.total_score = 0
			dice = DiceSet.new 5
			dice.rolls 5
			new_turn(dice,player)
		end
		new_round
	end
	
	def new_round
		puts "-----------Next Round-----------"
		@players.each do |player|
			puts "Player #{player.player_no + 1}\'s turn"
			dice = DiceSet.new 5
			dice.rolls 5
			new_turn(dice,player)
		end

		@players.each do |player|
			if player.total_score >= 3000
				@is_last_round = true
				last_round
				return
			else 
				new_round
			end
		end
		
	end

	def remove_scoring_dice(dice)
		dice = dice.reject {|x| dice.count(x) == 3}
		dice = dice.reject {|x| x == 1 || x == 5}
		dice
	end

	def new_turn(dice,player)
		score = Score.new
		puts "Your rolls are",dice.values.join(' ')
		current_move_score = score.each_move_score(dice.values)
		puts "current_move_score is:",current_move_score
		player.current_turn_score = current_move_score
		if current_move_score == 0
			player.current_turn_score == 0
			puts "Your turn is over"
			puts "Your total score is:",player.total_score
			return	
		end
		
		while 1	
			#puts "Your rolls are",dice.values.join(' ')
			if player.is_in_game == false
				unless player.current_turn_score < 300
					puts "You move to the next round.."
					player.total_score += player.current_turn_score
					puts "Your total score is:" ,player.total_score 
					player.is_in_game = true
					return
				end
			end	
			puts "Do you wish to continue? (Y/N)"
			if gets.chomp.downcase == 'y'
				dice = remove_scoring_dice(dice.values)
				length = dice.length
				dice = DiceSet.new (dice.length)
				dice.rolls(length)
				puts "Your rolls are",dice.values.join(' ')
				current_move_score = score.each_move_score(dice.values)
				puts "current_move_score is:",current_move_score
				if current_move_score == 0
					player.current_turn_score == 0
					puts "Your turn is over"
					puts "Your total score is:",player.total_score
					return	
				else 
					player.current_turn_score += current_move_score
					puts "Your current_turn_score:", player.current_turn_score
				

				end
			else 
				player.total_score += player.current_turn_score
				puts "Your total score is:" ,player.total_score
				return
			end
			
		end	
		player.total_score += player.current_turn_score
		puts "Your total score is:" ,player.total_score
	end
	def last_round
		puts "------------------Final round------------------"
		@players.each do |player|
			puts "Player #{player.player_no + 1}\'s turn"
			dice = DiceSet.new 5
			dice.rolls 5
			new_turn(dice,player)
		end
		highest_score = 0
		highest_player = 0
		@players.each do |player|
			if player.total_score > highest_score
				highest_score = player.total_score
				highest_player = player.player_no
			end
		end
		puts "------------------GAME OVER------------------"
		puts "----Player #{highest_player + 1} wins-----"

	end
end

class Score
	def each_move_score(dice)
		score = 0
		dice = dice.sort
		while dice.length > 0
			val = dice.shift
			if dice.length >= 2 && val == dice[0] && val == dice[1]
				score += val*100 if val != 1
				score += 1000 if val == 1
				dice.shift(2)
			else
				score += 100 if val == 1
				score += 50 if val == 5
			end
		end
		score
	end
end

class Player
	attr_accessor :current_turn_score
	attr_accessor :total_score
	attr_accessor :is_in_game

	def initialize(no)
		@player_no = no
		@is_in_game = false
	end

	def player_no
		player_no = @player_no
	end

end

class DiceSet

	def initialize(number_of_dices)
    	@number_of_dices = number_of_dices
  	end

	def rolls(number_of_dices)
		@values = (1..number_of_dices).map{ rand(6) + 1 }
	end
	def values
		@values
	end
end

puts "Enter the number of players"
no_of_players = gets.chomp.to_i 
players = []
player_no = 0
while no_of_players != 0
	players << Player.new(player_no)
	no_of_players -= 1
	player_no += 1
end

game = Game.new(players)
game.start_game()