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
