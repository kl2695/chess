require_relative "cursor"
require 'colorize'

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    board.grid.each_with_index do |row,i|
      color = i.odd?
      row.each_with_index do |piece,j|
        pos = [i, j]
        square = piece.to_s
        if color
          square = square.on_blue
        end
        if pos == cursor.cursor_pos || pos == cursor.select_pos
          square = square.on_red
        end

        print square
        color = !color
      end
      puts
    end
  end


  def test
    10.times do
      render
      cursor.get_input
      system 'clear'
    end
  end
end
