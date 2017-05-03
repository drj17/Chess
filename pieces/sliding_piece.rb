module SlidingPiece
  def generate_moves(deltas)
    valid_moves = []
    deltas.each do |delta|
      valid_moves.concat(generate_sliding_moves(delta))
    end
    valid_moves
  end

  private

  def generate_sliding_moves(delta)
    moves = []
    next_pos = find_next_pos(self.pos, delta)
    found_piece = false

    while valid_move?(next_pos) && !found_piece
      current_pos = next_pos
      found_piece = true if enemy_at?(current_pos)
      moves << current_pos
      next_pos = [current_pos[0] + delta[0], current_pos[1] + delta[1]]
    end
    moves
  end
end
