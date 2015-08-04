
class Piece
  attr_accessor :pos, :board, :color

  def initilaize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
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
end

class SlidingPiece < Piece

  def moves
    result = []
    row_orig, col_orig = pos
    DELTAS.each do |d_row, d_col|
      row_new, col_new  = row_orig + d_row, col_orig + d_col
      new_move = [row_new, col_new]
      while in_bounds?(new_move)
        result << new_move
        row_new += d_row
        col_new += d_col
        new_move = [row_new, col_new]
      end
    end
  end

end

class SteppingPiece < Piece

  def moves
    row_orig, col_orig = pos
    DELTAS.map do |d_row, d_col|
      new_move = [row_orig + d_row, col_orig + d_col]
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
end

class Bishop < SlidingPiece
  DELTAS = [
    [ 1,  1],
    [-1, -1],
    [ 1, -1],
    [-1,  1]
  ]

end

class Rook < SlidingPiece
  DELTAS = [
    [ 0,  1],
    [ 0, -1],
    [-1,  0],
    [ 1,  0]
  ]
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


end

class Pawn < Piece
end
