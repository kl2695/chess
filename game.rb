require_relative "piece"
require_relative "validate"
require_relative "display"
require_relative "board"
require_relative "player"
require_relative "cursor"

class Game

  attr_reader :display, :board

  def initialize(player1 = Player.new("Kevin"), player2 = Player.new("Matt"))
    @board = Board.new
    @display = Display.new(board)
    @current = player1
    @previous = player2
  end

  def play
    3.times do
      take_turn
    end
  end

  def take_turn
    puts "select a piece to move"
    selected = nil
    cursor = display.cursor
    until selected != nil
      display.render
      cursor.get_input
      selected = cursor.select_pos
      p selected
    end

    puts "select where to move"
    selected2 = nil
    cursor.select_pos = nil
    until selected2
      selected2 = cursor.select_pos
      display.render
      cursor.get_input
    end

    board.move_piece(selected, selected2)

  end

  def switch_turn
  end

  def won?
  end









end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
