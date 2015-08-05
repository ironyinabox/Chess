require_relative 'pieces'
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

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_board
  end

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

  def in_check?(color)
    king_pos = find_king(color)
    pieces.any? { |tile| tile.color != color && tile.moves.include?(king_pos) }
  end

  def find_king(color)
    pieces.each { |tile| return tile.pos if tile.is_a?(King) && tile.color == color }
  end

  def assign_color
    (0..1).each { |idx| rows[idx].each { |piece| piece.set_color(:black)} }
    (6..7).each { |idx| rows[idx].each { |piece| piece.set_color(:white)} }
  end

  def move(start, end_pos)
    raise InvalidMoveError if self[start].nil? ||
    !self[start].valid_moves.include?(end_pos)

    self[end_pos] = self[start]
    self[start] = nil

    self[end_pos].update_pos(end_pos)

    nil
  end

  def move!(start, end_pos)
    self[end_pos] = self[start]
    self[start] = nil

    self[end_pos].update_pos(end_pos)

    nil
  end

  def render
    puts ""
    puts "   0 1 2 3 4 5 6 7"
    puts "  ________________"
    rows.each_with_index do |row, row_idx|
      print "#{row_idx} |"
      row.each do |piece|
        piece.is_a?(Piece) ? (print piece.to_s + " ") : (print "_ ")
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
    dup_board = Board.new
    pieces.each do |piece|
      piece.dup(dup_board)
    end

    dup_board
  end

  def rows
    grid
  end

  def pieces
    rows.flatten.compact
  end

  # def black_pieces
  #   p
  #   rows.flatten.compact.select { |piece| piece.color == :black}
  # end
  #
  # def white_pieces
  #   rows.flatten.compact.select { |piece| piece.color == :white}
  # end

  def checkmate?(color)
    pieces.each { |piece| return false if piece.color == color && piece.valid_moves.size > 0 }
    true
  end
end

class InvalidMoveError < StandardError
end
