require_relative 'piece'
require_relative 'sliding_piece'

class Queen < Piece
  include SlidingPiece
  DELTAS = [[-1, -1],
            [-1, +1],
            [+1, -1],
            [+1, +1],
            [-1, +0],
            [+1, +0],
            [+0, -1],
            [+0, +1]]

  def initialize(pos, board, color)
    super(pos, board, color)
    @value = 4
  end

  def moves
    generate_moves(DELTAS)
  end

  def to_s
    color == :black ? "♛" : "♕"
  end
end
