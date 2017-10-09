require_relative "piece"


class Board

  attr_reader :grid

  def initialize
    @grid = Board.setup

  end

  def self.setup
    puts "runiing"
    grid = Array.new(8)
    grid.map!.with_index do |el,idx|
      top_and_bottom = [0,1,6,7]
      if top_and_bottom.include?(idx)
        Array.new(8){Piece.new}
      else
        Array.new(8){Nullpiece.instance}
      end
    end
    return grid
  end

  def move_piece(start_pos, end_pos)
    raise StandardError, "No piece at this position" if self[start_pos].is_a? Nullpiece
    self[end_pos] = self[start_pos]
    self[start_pos] = Nullpiece.instance
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def in_bounds?(pos)
    pos.all?{|x| x.between?(0,7)}
  end

end
