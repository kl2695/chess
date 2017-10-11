module ValidateMoves

  def sliding_positions(piece, current_pos)
    positions = piece.moves(current_pos)

    positions.each do |dir|
      dir.each do |pos|
        if empty_space?(pos)
          possible_moves << pos
        else
          possible_moves << pos unless piece.color == self[pos].color
          break
        end
      end
    end
    possible_moves
  end

  def knight_positions(piece, current_pos)
    positions = piece.moves(current_pos)
    p positions

    positions.reject do |pos|
      self[pos].color == piece.color || !in_bounds?(pos)
    end
  end

  def king_positions(piece, current_pos)
    positions = piece.moves(current_pos)

    positions.reject do |pos|
      board[pos].color == piece.color ||
      !in_bounds?(pos) ||
      attacked?(pos, piece)
    end
  end

  def attacked?(king_pos, piece)
    positions = []
    8.times do |i|
      8.times do |j|
        pos = [i, j]
        current_piece = self[pos]
        return true if valid_moves(pos, current_piece).include?(king_pos)
      end
    end
    false
  end

  def pawn_positions(piece, current_pos)

    positions = piece.moves(current_pos)
    puts "pawn positions: #{positions}"

    moves = []

    positions[:straight].each do |pos|
      break unless in_bounds?(pos) && empty_space?(pos)
      moves << pos
    end

    positions[:diagonal].each do |pos|
      next if !in_bounds?(pos) || empty_space?(pos)
      if self[pos].color != piece.color
        moves << pos
      end
    end
    moves
  end

end
