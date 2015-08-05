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
    rescue InvalidMoveError => e
      puts "That is not a valid move"
      puts "#{e}"
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
    input = gets.chomp
    until valid_input(input)
      puts "That is an invalid move, try again:"
      input = gets.chomp
    end

    [parse_input(input).take(2), parse_input(input).drop(2)]
  end

  def prompt
    puts "#{current_player.to_s}: It is your turn!"
    puts "Please enter a move: (eg. 6040)"
  end

  def valid_input(input)
    digits = parse_input(input)
    digits.length == 4 && digits.all? { |x| x.between?(0,7)}
  end

  def current_player
    players.first
  end

  def parse_input(input)
    input.scan(/\d/).map(&:to_i)
  end

  def switch_players!
    players.reverse!
  end
end

game = Game.new
game.run
