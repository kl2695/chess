require 'singleton'

class Piece

  attr_reader :dirs

  def initalize(current_pos, color, dirs)
    @current_pos = current_pos
    @color = color
    @dirs = dirs
  end

  def to_s
    "*"
  end

end

class Nullpiece < Piece
  include Singleton
end

module SlidingPieces

  def moves(board)
    positions = []

    straight = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    diagonal = [[1, 1], [-1, -1], [1, -1], [-1, 1]]

    directions = [straight, diagonal].select do |dir|
      dirs.include?(dir, board)
    end

    directions.each { |dir| positions += find_positions(dir) }

    positions
  end

  def find_positions(dir, board)
    pos = [current_pos[0] + dir[0], current_pos[1] + dir[1]]
    while pos.all? { |x| range.include?(x) }
      unless board.empty_space?(pos)
        positions << pos if board[pos].color != color
        break
      end
      positions << pos
      pos = [pos[0] + dir[0], pos[1] + dir[1]]
    end
    positions
  end


end


# TODO make steppingpieces module, then make sliding pieces subclasses, then stepping pieces subclasses
module SteppingPieces

end




# def straight_moves
#   moves = []
#
#   directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
#
#   (0..7).to_a.each do |col|
#     next if col == current_pos.last
#     moves << [current_pos.first, col]
#   end
#   (0..7).to_a.each do |row|
#     next if row == current_pos.first
#     moves << [row, current_pos.last]
#   end
#
#   moves
# end
#
# def diagonal_moves
#   moves = []
#
#   range = (0..7).to_a
#
#   directions = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
#
#   directions.each do |dir|
#     pos = [current_pos[0] + dir[0], current_pos[1] + dir[1]]
#     while pos.all? { |x| range.include?(x) }
#       moves << pos
#       pos = [pos[0] + dir[0], pos[1] + dir[1]]
#     end
#   end
#
#   moves
# end
