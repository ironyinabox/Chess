require 'colorize'

class Piece

  attr_accessor :pos, :board, :color

  def initialize(pos, board=nil, color = nil)
    @pos = pos
    @board = board
    @color = color
  end

  def set_color(color)
    self.color = color
  end

  def update_pos(end_pos)
    self.pos = end_pos
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move)}
  end

  def occupied_by_ally?(move_pos)
    return false if board[move_pos].nil?
    board[move_pos].color == self.color
  end

  def capturable?(move_pos)
    return true if board[move_pos].nil?
    board[move_pos].color != self.color
  end

  def move_into_check?(move_pos)
    dup_board = board.dup
    dup_board.move!(pos, move_pos)
    dup_board.in_check?(color)
  end

  def in_bounds?(move_pos)
    move_pos.all? { |point| point.between?(0,7)}
  end

  def colorize_output(str)
    options = {}
    options[:color] = (color == :white ? :red : :black)
    options[:background] = (self.pos.inject(:+) % 2 == 0 ? :white : :green)
    str.colorize(options)
  end

  def calc_new_move(d_pos)
    row_orig, col_orig = pos
    d_row, d_col = d_pos
    new_row, new_col = d_row + row_orig, d_col + col_orig
    [new_row, new_col]
  end

  def dup(dup_board)
    dup_piece = self.class.new(pos.dup, dup_board, color)
    dup_board[dup_piece.pos] = dup_piece
  end
end
