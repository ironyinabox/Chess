class Pawn < Piece
  attr_accessor :moved

  DELTA = [
            [ 1,  0], # black moves
            [-1,  0] # white moves
          ]
  CAPTURE_MOVES = [
    [ [ 1, -1], [ 1,  1] ], #black moves
    [ [-1, -1], [-1,  1] ] #white moves
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

  def capturable?(move_pos)
    return false if board[move_pos].nil?
    board[move_pos].color != color
  end

  def occupied?(move_pos)
    !board[move_pos].nil?
  end

  def update_pos(end_pos)
    self.pos = end_pos
    self.moved = true
  end

  def moves
    result = []

    color_setter = (color == :black ? 0 : 1)

    ## handles single moves
    d_pos = DELTA[color_setter]
    new_move = calc_new_move(d_pos)
    result << new_move if in_bounds?(new_move) && !occupied?(new_move)

    ## handles double move
    d_pos = DOUBLE_MOVE[color_setter]
    new_move = calc_new_move(d_pos)
    result << new_move if in_bounds?(new_move) && !moved? && !result.empty? && !occupied?(new_move)

    ## handles capture moves
    CAPTURE_MOVES[color_setter].each do |c_pos|
      new_move = calc_new_move(c_pos)
      result << new_move if in_bounds?(new_move) && capturable?(new_move)
    end

    result
  end

  def to_s
    colorize_output("P")
  end
end
