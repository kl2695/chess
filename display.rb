require_relative "cursor"
require_relative "board"
require 'colorize'

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    puts "_" * 26
    board.grid.each_with_index do |row,i|
      print "| "
      row.each_with_index do |piece,j|
        square = piece.to_s
        if [i,j] == cursor.cursor_pos
          print square.red
        else
          print square
        end
        print " |"
      end
      puts
      puts "_" * 26
    end
    nil
  end

  def test
    10.times do
      render
      cursor.get_input
      system 'clear'
    end
  end
end
