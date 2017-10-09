require 'singleton'

class Piece

  def initalize
  end

  def to_s
    "*"
  end

end

class Nullpiece < Piece
include Singleton



end
