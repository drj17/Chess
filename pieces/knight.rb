require_relative 'piece'
require_relative 'stepping_piece'

class Knight < Piece
  include SteppingPiece
  DELTAS = [
      [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1]
      ]
  def initialize(pos, board, color)
    super(pos, board, color)
    @value = 2
  end
  def moves
    generate_moves(DELTAS)
  end

  def to_s
    color == :black ? "♞" : "♘"
  end
end
