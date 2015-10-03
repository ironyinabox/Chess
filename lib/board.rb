require 'byebug'
class Board

  attr_accessor :grid

  START_POS = {
    :rook =>   [ [7,0], [7,7], [0,0], [0,7] ],
    :knight => [ [7,1], [7,6], [0,1], [0,6] ],
    :bishop => [ [7,2], [7,5], [0,2], [0,5] ],
    :king =>   [ [7,4], [0,4] ],
    :queen =>  [ [7,3], [0,3] ]
  }

  def initialize(dup = false)
    @grid = Array.new(8) { Array.new(8) }
    setup_board unless dup
  end


  def move(start, end_pos)
    raise InvalidMoveError if self[start].nil? ||
      !self[start].valid_moves.include?(end_pos)
    move!(start, end_pos)
    nil
  end

  def move!(start, end_pos)
    self[end_pos] = self[start]
    self[start] = nil
    self[end_pos].update_pos(end_pos)

    nil
  end

  def render
    puts
    puts "    a  b  c  d  e  f  g  h "
    rows.each_with_index do |row, row_idx|
      print "#{8 - row_idx}  "
      row.each_with_index do |piece, col_idx|
        if piece.is_a?(Piece)
          print piece.to_s
        elsif (row_idx + col_idx) % 2 == 0
          print "   ".colorize(background: :light_white)
        else
          print "   ".colorize(background: :white)
        end
      end

      puts

    end
    puts
    nil
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def dup
    dup_board = Board.new(true)
    pieces.each do |piece|
      piece.dup(dup_board)
    end
    dup_board
  end

  def rows
    grid
  end

  def no_valid_moves?(color)
    pieces(color).all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def pieces(color = nil)
    return rows.flatten.compact if color == nil
    rows.flatten.compact.select { |piece| piece.color == color }
  end

  def checkmate?(color)
    in_check?(color) && no_valid_moves?(color)
  end

  def in_check?(color)
    king_pos = find_king(color)
    enemy_pieces = (color == :white ? pieces(:black) : pieces(:white))
    enemy_pieces.any? { |piece| piece.moves.include?(king_pos) }
  end

  def find_king(color)
    pieces.each { |tile| return tile.pos if tile.is_a?(King) && tile.color == color }
  end

  private

  def setup_board
    START_POS.keys.each do |piece_type|
      START_POS[piece_type].each do |pos|
        case piece_type
        when :rook
          self[pos] = Rook.new(pos, self)
        when :knight
          self[pos] = Knight.new(pos, self)
        when :queen
          self[pos] = Queen.new(pos, self)
        when :king
          self[pos] = King.new(pos, self)
        when :bishop
          self[pos] = Bishop.new(pos, self)
        end
      end
    end
    rows[1].each_with_index { |_, col| self[[1, col]] = Pawn.new([1, col], self, nil) }
    rows[6].each_with_index { |_, col| self[[6, col]] = Pawn.new([6, col], self, nil) }
    assign_color
    nil
  end

  def assign_color
    (0..1).each { |idx| rows[idx].each { |piece| piece.set_color(:black)} }
    (6..7).each { |idx| rows[idx].each { |piece| piece.set_color(:white)} }
    nil
  end
end

class InvalidMoveError < StandardError
end
