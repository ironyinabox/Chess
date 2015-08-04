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

  def move(end_pos)
    pos = end_pos
  end

  def move_into_check?(pos)
    dup_board
  end

  def capture(otr_piece)
  end

  def be_captured
  end

  def in_bounds?(pos)
    pos.all? { |point| point.between?(0,7)}
  end

  def colorize_output(str)
    if color == :white
      str.colorize(:color => :red, :mode => :bold)
    else
      str.colorize(:color => :black, :mode => :bold)
    end
  end

  def calc_new_move(d_row, d_col)
    row_orig, col_orig = pos
    new_row, new_col = d_row + row_orig, d_col + col_orig
    [new_row, new_col]
  end
end
