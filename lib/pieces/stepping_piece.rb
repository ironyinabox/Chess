class SteppingPiece < Piece

  def moves
    self.class::DELTAS.map do |d_pos|
      new_move = calc_new_move(d_pos)
      in_bounds?(new_move) && capturable?(new_move) ? new_move : next
    end.reject { |move| move.nil? }

  end
end
