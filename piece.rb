
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
end

class SlidingPiece < Piece

end

class SteppingPiece < Piece

end

class Queen < SlidingPiece
end

class Bishop < SlidingPiece
end

class Rook < SlidingPiece
end

class Knight < SteppingPiece
end

class King < SteppingPiece
  KING_DELTAS = [
           [-1, -1],
           [-1, 0],
           [-1, 1],
           [0, 1],
           [0, -1],
           [1, -1],
           [1, 0],
           [1, 1]
         ]

  def moves
    row_orig, col_orig = pos
    KING_DELTAS.map do |d_row, d_col|
      [row_orig + d_row, col_orig + d_col]
    end
  end
end

class Pawn < Piece
end
