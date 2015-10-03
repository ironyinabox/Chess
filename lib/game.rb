require_relative 'reqs'
class Game
  attr_accessor :players, :board

  def initialize (board = Board.new)
    @board = board
    @players = [:white, :black]
  end

  def run
    until board.checkmate?(@players[0]) || board.checkmate?(@players[1])
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
    [parse_input(input)[0], parse_input(input)[1]]
  end

  def prompt
    color_options = {}
    color_options[:color] = (current_player == :white ? :red : :blue)
    puts "#{current_player.to_s}: It is your turn!\nPlease enter a move: (eg. e2-e4)"
      .colorize(color_options)
  end

  def valid_input(input)
    digits = parse_input(input)
    digits.flatten.length == 4 && digits.flatten.all? { |x| x.between?(0,7)}
  end

  def parse_input(input)
    parsed = input.scan(/[a-hA-H][1-8]/)
    raise InvalidMoveError if parsed.size < 2
    start_col_idx = parsed[0][0].downcase.ord - 97
    end_col_idx = parsed[1][0].downcase.ord - 97
    start_row_idx = 8 - (parsed[0][1].to_i)
    end_row_idx = 8 - (parsed[1][1].to_i)
    return [ [start_row_idx, start_col_idx], [end_row_idx, end_col_idx] ]
  end

  def current_player
    players.first
  end

  def switch_players!
    players.reverse!
  end
end

game = Game.new
game.run
