require_relative 'piece'

class Pawn < Piece
  FIRST_DELTAS = {black: [[+1, 0], [+2, 0]],
                  white: [[-1, 0], [-2, 0]]}
  DELTAS = {black: [[+1, 0]],
           white: [[-1, 0]]}
  ATTACK_DELTAS = {black: [[+1, -1], [+1, +1]],
                   white: [[-1, -1], [-1, +1]] }

  attr_accessor :first_move

  def initialize(pos, board, color)
    super(pos, board, color)
    @first_move = true
    @value = 1
  end

  def moves
    moves = []

    if @first_move
      moves.concat(generate_first_moves)
    else
      moves.concat(generate_moves)
    end

    moves.concat(generate_attacking_moves)
    moves
  end

  def generate_first_moves
    first_moves = []
    FIRST_DELTAS[self.color].each do |delta|
      next_pos = find_next_pos(self.pos, delta)
      if valid_move?(next_pos)
        first_moves << next_pos unless enemy_at?(next_pos)
      end
    end
    first_moves
  end

  def generate_attacking_moves
    attacking_moves = []
    ATTACK_DELTAS[self.color].each do |delta|
      next_pos = find_next_pos(self.pos, delta)
      attacking_moves << next_pos if enemy_at?(next_pos)
    end
    attacking_moves
  end

  def generate_moves
    moves = []
    DELTAS[self.color].each do |delta|
      next_pos = find_next_pos(self.pos, delta)
      if valid_move?(next_pos)
        moves << next_pos unless enemy_at?(next_pos)
      end
    end
    moves
  end

  def to_s
    color == :black ? "♟" : "♙"
  end
end
