module SteppingPiece
  def generate_moves(deltas)
    moves = []
    deltas.each do |delta|
      next_pos = find_next_pos(self.pos, delta)
      if valid_move?(next_pos)
        moves << next_pos
      end
    end
    moves
  end
end
