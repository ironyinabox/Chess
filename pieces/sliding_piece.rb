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
