require_relative 'piece'

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
    rows[1].each_with_index { |_, col| self[[1, col]] = Pawn.new([1, col], self) }
    rows[6].each_with_index { |_, col| self[[6, col]] = Pawn.new([6, col], self) }
    assign_color
    nil
  end

  def assign_color
    (0..1).each { |idx| rows[idx].each { |piece| piece.set_color(:black)} }
    (6..7).each { |idx| rows[idx].each { |piece| piece.set_color(:white)} }
  end

  def render
    rows.each do |row|
      row.each do |piece|
        print "#{piece.to_s} "
      end
      puts
    end
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

  def rows
    grid
  end

  def cols
    grid.transpose
  end
end


test = Board.new
test.render
