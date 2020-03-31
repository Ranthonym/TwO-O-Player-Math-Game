require_relative 'question'
require_relative 'input'
require_relative 'player'
require_relative 'output'

# every game should have 1) a question, 2) correct or wrong answer message, 3) P1 and P2 score update, 4) NEW TURN string 5) switch to other player

# start by default Player 1 turn, call question class, after evaluation by Question, 
# out right/wrong. show new score and then switch to player 2 turn

class Game

  def initialize
    # create player 1 and player 2 objects
    @players = [Player.new("1"), Player.new("2")]
  end

  def display_score
    sorted_players = @players.sort_by{|player| player.name}
    puts " Current score is  P#{sorted_players[0].name}: #{sorted_players[0].score_tracker} vs P#{sorted_players[1].name}: #{sorted_players[1].score_tracker}"
  end

  def current_player
    @players[0]
  end

  def other_player
    @players[1]
  end

  def next_player_turn
    @players = @players.rotate(-1)
  end

  

  def start
    # main game loop
    while (current_player.score != 0 && other_player.score != 0) do
      
      @question = Question.new
      puts "P#{current_player.name}: #{@question}"

      response = Input.new
      response.read_answer!
      result = @question.correct_answer?(response.answer)

      if result
        puts "YES! Right answer!"
      else 
        puts "No! Wrong answer!"
        current_player.score -= 1
        puts current_player.score
      end

      self.display_score
      puts "----- NEW TURN ------"
      self.next_player_turn
    end
    winner = @players.sort_by{|player| player.score}.last
    puts "P#{winner.name} wins with score of #{winner.score_tracker}"
    puts "----- GAME OVER ----"

  end
end

g = Game.new
puts g.start