require 'singleton'
require_relative "pieces_modules"

class Piece

  attr_reader :dirs, :color, :to_s

  def initialize(color)
    @color = color
  end

  def respond
  end

end

class Nullpiece < Piece
  include Singleton

  def initialize(color = nil)
    @color = color
    @dirs = nil
    @to_s = '   '
  end
end


class Bishop < Piece
  include SlidingPieces

  DIRECTIONS = [:diagonal]

  def initialize(color)
    super(color)
    @dirs = DIRECTIONS
    @to_s = color == :black ? ' ♝ ' : ' ♗ '
  end
end

class Rook < Piece
  include SlidingPieces

  DIRECTIONS = [:straight]

  def initialize(color)
    super(color)
    @dirs = DIRECTIONS
    @to_s = color == :black ? ' ♜ ' : ' ♖ '
  end
end

class Queen < Piece
  include SlidingPieces

  DIRECTIONS = [:straight, :diagonal]

  def initialize(color)
    super(color)
    @dirs = DIRECTIONS
    @to_s = color == :black ? ' ♛ ' : ' ♕ '
  end
end

class Knight < Piece
  include SteppingPieces

  DIRECTIONS = [
    [1, 2], [2, 1], [-1, 2], [2, -1],
    [-2, 1], [1, -2], [-1, -2], [-2, -1]
  ]

  def initialize(color)
    super(color)
    @dirs = DIRECTIONS
    @to_s = color == :black ? ' ♞ ' : ' ♘ '
  end
end

class King < Piece
  include SteppingPieces

  DIRECTIONS = [
    [0, 1], [0, -1], [1, 0], [-1, 0],
    [1, 1], [1, -1], [-1, 1], [-1, -1]
  ]

  def initialize(color)
    super(color)
    @dirs = DIRECTIONS
    @to_s = color == :black ? ' ♚ ': ' ♔ '
  end
end

class Pawn < Piece
  # include SteppingPieces
  DIRECTIONS = {
    straight: [[1, 0], [2, 0]],
    diagonal: [[1, -1], [1, 1]]
  }

  def initialize(color)
    super(color)
    @dirs = DIRECTIONS
    @to_s = color == :black ? ' ♟ ' : ' ♙ '
  end

  def moves(current_pos)
    moves = {straight: [], diagonal: []}

    dirs.each do |dir, arr|
      arr.each do |val|
        moves[dir] << [val[0] + current_pos[0], val[1] + current_pos[1]]
      end
    end

    moves
  end

  def respond
    dirs[:straight].delete([2, 0])
  end

end
