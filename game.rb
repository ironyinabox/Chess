require_relative 'board'

class Game
  attr_accessor :players, :board

  def initialize (board = Board.new)
    @board = board
    @players = [:white, :black]
  end

  def run
    until board.checkmate?(current_player)
      board.render
      play_turn
    end

    end_game
  end

  def play_turn
    begin
      new_move = get_move
      board.move(new_move.first, new_move.last)
    rescue
      puts "That is not a valid move"
      retry
    end

    switch_players!
  end

  def end_game
    board.render
    puts "Congrats, #{players[1]}, you won!"
  end

  def get_move
    prompt
    parse_input(gets.chomp)
  end

  def prompt
    puts "#{current_player.to_s}: It is your turn!"
    puts "Please enter a move: (eg. 6040)"
  end

  def valid_input(input)
    board[input[0]].color == current_player
  end

  def current_player
    players.first
  end

  def parse_input(str)
    nums = str.split('').map(&:to_i)
    [ [ nums[0], nums[1] ], [ nums[2], nums[3] ] ]
  end

  def switch_players!
    players.reverse!
  end
end

game = Game.new
game.run
