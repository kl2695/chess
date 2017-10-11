module SlidingPieces

  def moves(current_pos)
    positions = []

    directions_hash = {
      straight: [[1, 0], [-1, 0], [0, 1], [0, -1]],
      diagonal: [[1, 1], [-1, -1], [1, -1], [-1, 1]]
    }

    directions = directions_hash.select do |direction, _|
      self.dirs.include?(direction)
    end

    directions.each do |direction, pos_array|
      poss_array.each { |dir| positions << find_positions(current_pos, dir) }
    end

    positions

  end



  def find_positions(current_pos, dir)
    pos = [current_pos[0] + dir[0], current_pos[1] + dir[1]]
    while pos.all? { |x| range.include?(x) }
      positions << pos
      pos = [pos[0] + dir[0], pos[1] + dir[1]]
    end
    positions
  end

end


module SteppingPieces

  def moves(current_pos)

    positions = []

    self.dirs.each do |pos|
      positions << [pos[0] + current_pos[0], pos[1] + current_pos[1]]
    end

    positions
  end
end
