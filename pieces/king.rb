require_relative 'piece'
require_relative 'stepping_piece'
class King < Piece
  include SteppingPiece
  DELTAS = [[-1, -1],
            [-1, +1],
            [+1, -1],
            [+1, +1],
            [-1, +0],
            [+1, +0],
            [+0, -1],
            [+0, +1]]
  def moves
    generate_moves(DELTAS)
  end

  def to_s
    color == :black ? "♚" : "♔"
  end
end
