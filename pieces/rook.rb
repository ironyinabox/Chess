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
