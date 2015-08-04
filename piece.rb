
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
