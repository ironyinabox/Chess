class SteppingPiece < Piece

  def moves
    self.class::DELTAS.map do |d_row, d_col|
      new_move = calc_new_move(d_row, d_col)
      in_bounds?(new_move) ? new_move : next
    end
  end
end
