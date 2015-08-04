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
