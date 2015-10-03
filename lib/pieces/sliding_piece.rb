class SlidingPiece < Piece

  def moves
    result = []

    self.class::DELTAS.each do |d_pos|
      d_row, d_col = d_pos
      new_move = calc_new_move(d_pos)

      row_new, col_new = new_move
      while in_bounds?(new_move) && !occupied?(new_move)
        result << new_move
        row_new += d_row
        col_new += d_col
        new_move = [row_new, col_new]
      end

      result << new_move if in_bounds?(new_move) && capturable?(new_move)
    end

    result
  end

  def occupied?(new_move)
    !board[new_move].nil?
  end
end
