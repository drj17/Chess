require_relative 'piece'
require 'singleton'

class NullPiece < Piece
  include Singleton

  def to_s
    " "
  end
end
