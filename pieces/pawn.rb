class Pawn < Piece
  attr_accessor :moved

  DELTAS = [
            [ 1, -1],  # black moves
            [ 1,  0],
            [ 1,  1],
            [-1, -1], # white moves
            [-1,  0],
            [-1,  1]
          ]
  DOUBLE_MOVE = [
            [ 2,  0], #black
            [-2,  0]  #white
  ]

  def initialize(pos, board, color)
    super(pos, board, color)
    @moved = false
  end

  def moved?
    moved
  end

  def moves
    result = []
    case color
    when :black
      DELTAS.take(3).each do |d_row, d_col|
        new_move = calc_new_move(d_row, d_col)
        result << new_move if in_bounds?(new_move)
      end

      if !moved?
        d_row, d_col = DOUBLE_MOVE[0]
        d_move = calc_new_move(d_row, d_col)
        result << d_move if in_bounds?(d_move)
      end
    when :white
      DELTAS.drop(3).each do |d_row, d_col|
        new_move = calc_new_move(d_row, d_col)
        result << new_move if in_bounds?(new_move)
      end

      if !moved?
        d_row, d_col = DOUBLE_MOVE[1]
        d_move = calc_new_move(d_row, d_col)
        result << d_move if in_bounds?(d_move)
      end
    end
    result
  end

  def to_s
    colorize_output("P")
  end
end
