
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

  def moves
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

class SlidingPiece < Piece

  def moves
    result = []
    self.class::DELTAS.each do |d_row, d_col|
      new_move = calc_new_move(d_row, d_col)
      row_new, col_new = new_move
      while in_bounds?(new_move)
        result << new_move
        row_new += d_row
        col_new += d_col
        new_move = [row_new, col_new]
      end
    end
    
    result
  end
end

class SteppingPiece < Piece

  def moves
    self.class::DELTAS.map do |d_row, d_col|
      new_move = calc_new_move(d_row, d_col)
      in_bounds?(new_move) ? new_move : next
    end
  end
end

class Queen < SlidingPiece
  DELTAS = [
     [-1, -1],
     [-1,  0],
     [-1,  1],
     [ 0,  1],
     [ 0, -1],
     [ 1, -1],
     [ 1,  0],
     [ 1,  1]
   ]

   def to_s
     colorize_output("Q")
   end
end

class Bishop < SlidingPiece

  DELTAS = [
    [ 1,  1],
    [-1, -1],
    [ 1, -1],
    [-1,  1]
  ]

  def to_s
    colorize_output("B")
  end
end

class Rook < SlidingPiece

  DELTAS = [
    [ 0,  1],
    [ 0, -1],
    [-1,  0],
    [ 1,  0]
  ]

  def to_s
    colorize_output("R")
  end
end

class Knight < SteppingPiece

  DELTAS = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  def to_s
    colorize_output("N")
  end
end

class King < SteppingPiece

  DELTAS = [
     [-1, -1],
     [-1,  0],
     [-1,  1],
     [ 0,  1],
     [ 0, -1],
     [ 1, -1],
     [ 1,  0],
     [ 1,  1]
   ]

   def to_s
     colorize_output("K")
   end
end

class Pawn < Piece
  attr_accessor :moved

  DELTAS = [
            [ 1, -1],  # black moves
            [ 1,  0],
            [ 1,  1],
            [-1, -1], # white moves
            [-1,  0],
            [-1,  1]
          ]
  DOUBLE_MOVE = [
            [ 2,  0], #black
            [-2,  0]  #white
  ]

  def initialize(pos, board, color)
    super(pos, board, color)
    @moved = false
  end

  def moved?
    moved
  end

  def moves
    result = []
    case color
    when :black
      DELTAS.take(3).each do |d_row, d_col|
        new_move = calc_new_move(d_row, d_col)
        result << new_move if in_bounds?(new_move)
      end

      if !moved?
        d_row, d_col = DOUBLE_MOVE[0]
        d_move = calc_new_move(d_row, d_col)
        result << d_move if in_bounds?(d_move)
      end
    when :white
      DELTAS.drop(3).each do |d_row, d_col|
        new_move = calc_new_move(d_row, d_col)
        result << new_move if in_bounds?(new_move)
      end

      if !moved?
        d_row, d_col = DOUBLE_MOVE[1]
        d_move = calc_new_move(d_row, d_col)
        result << d_move if in_bounds?(d_move)
      end
    end
    result
  end

  def to_s
    colorize_output("P")
  end
end
