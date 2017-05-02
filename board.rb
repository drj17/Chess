class Board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    self.populate
  end

  def []=(pos, val)
    x, y = pos
    @board[x][y] = val
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def move_piece(start_pos, end_pos)

  end
end
