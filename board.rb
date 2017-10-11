class Board
  include ValidateMoves

  attr_reader :grid

  def initialize
    @grid = Board.setup
  end

  def self.setup
    grid = Array.new(8)

    grid.map!.with_index do |row, idx|
      case idx
      when 0
        Board.setup_end_row(:black)
      when 1
        Array.new(8) { Pawn.new(:black) }
      when 6
        Array.new(8) { Pawn.new(:white) }
      when 7
        Board.setup_end_row(:white)
      else
        Array.new(8) { Nullpiece.instance }
      end
    end

    grid
  end

  def self.setup_end_row(color)
    Array.new(8).map.with_index do |el,idx|
      case idx
      when 0,7
        Rook.new(color)
      when 1,6
        Knight.new(color)
      when 2,5
        Bishop.new(color)
      when 3
        Queen.new(color)
      when 4
        King.new(color)
      end
    end

  end

  def valid_moves(current_pos, piece)

    type = piece.class

    if type == Queen || type == Rook || type == Bishop
      sliding_positions(piece, current_pos)
    elsif type == Knight
      puts "knight moves"
      knight_positions(piece, current_pos)
    elsif type == King
      king_positions(piece, current_pos)
    elsif Pawn

      pawn_positions(piece, current_pos)
    end
  end


  def move_piece(start_pos, end_pos)
    raise StandardError, "No piece at this position" if self[start_pos].is_a? Nullpiece
    if valid_moves(start_pos, self[start_pos]).include?(end_pos)
      self[end_pos] = self[start_pos]
      self[start_pos] = Nullpiece.instance
    else
      puts "invalid move"
      raise InvalidMoveError, "Move is not valid!"
    end
  end

  def empty_space?(pos)
    self[pos] == Nullpiece.instance
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
