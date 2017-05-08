class Piece

  attr_reader :board, :color, :value
  attr_accessor :pos


  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
    @value = 0
  end

  def inspect
    to_s
  end

  def valid_move?(next_pos)
    return false unless board.in_bounds?(next_pos)
    if board[next_pos].is_a?(NullPiece) || enemy_at?(next_pos)
      return true
    else
      return false
    end
  end

  def valid_moves
    potential_moves = self.moves
    potential_moves.reject! do |move|
      next_board = @board.dup
      next_board.move_piece(self.pos, move, false)
      next_board.in_check?(self.color)
    end
    potential_moves
  end

  def enemy_at?(next_pos)
    return false unless self.board.in_bounds?(next_pos)
    if self.color == :white
      self.board[next_pos].color == :black
    elsif self.color == :black
      self.board[next_pos].color == :white
    end
  end

  def find_next_pos(pos, delta)
    new_x = pos[0] + delta[0]
    new_y = pos[1] + delta[1]
    next_pos = new_x, new_y
  end

  def to_s
    "."
  end
end
