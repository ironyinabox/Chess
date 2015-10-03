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
     colorize_output(" ♚ ")
   end
end
