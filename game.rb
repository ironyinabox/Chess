require_relative 'board'

class Game
  attr_accessor :players, :board

  def initialize (board = Board.new)
    @board = board
    players = [:white, :black]
  end

  def run
    until over?
      board.render
      play_turn
    end
  end

  def over?
    checkmate? || draw?
  end

  def checkmate?
    false
  end

  def draw?
    false
  end

  def play_turn
    new_move = get_move
    p new_move
    board.move(new_move.first, new_move.last)
    switch_players!
  end

  def get_move
    prompt
    input = gets.chomp

    until valid_input(input)
      puts "Not a valid move, please try again"
      input = gets.chomp
    end

    convert_input(input)
  end

  def prompt
    puts "Please enter a move: "
  end

  def valid_input(input)
    true
  end

  def current_player
    players.first
  end

  def convert_input(input)
    formatted_input = input.split("").map{|el| el.to_i}
    start_pos = formatted_input[0..1]
    end_pos = formatted_input[2..3]
    [start_pos, end_pos]
  end

  def switch_players!
    players.push(players.shift)
  end
end

game = Game.new
game.run
