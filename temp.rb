class Board

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    self.place_pieces

  end

  def []=(pos, val)
    x, y = pos
    @board[x][y] = val
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def place_pieces
    place_pawns
    place_capital_pieces
    place_null_pieces
  end

  def move_piece(start_pos, end_pos, errors = true)
    if errors
      raise InvalidMove unless self[start_pos].valid_moves.include?(end_pos)
    end
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos].pos = end_pos
    self[end_pos].first_move = false if self[end_pos].is_a?(Pawn)
  end

  def in_bounds?(pos)
    x, y = pos
    return false if x > 7 || y > 7 || x < 0 || y < 0
    true
  end

  def in_check?(color)
    moves = []
    king_pos = get_king_pos(color)
    pieces = get_pieces(color == :black ? :white : :black)
    pieces.each do |piece|
      moves.concat(piece.moves)
    end
    moves.each do |move|
      return true if king_pos == move
    end
    false
  end

  def get_pieces(color)
    pieces = []
    self.board.each do |row|
      row.each do |piece|
        next if piece.is_a?(NullPiece)
        if piece.color == color
          pieces << piece
        end
      end
    end
    pieces
  end

  def get_king_pos(color)
    king = get_pieces(color).select { |piece| piece.is_a?(King) }
    king.first.pos
  end

  def checkmate?(color)
    pieces = get_pieces(color)
    in_check?(color) && pieces.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def dup
    result = Board.new
    8.times do |i|
      8.times do |j|
        pos = i, j
        if self[pos].class == NullPiece
          result[pos] = self[pos]
        else
          result[pos] = self[pos].class.new(pos, result, self[pos].color)
        end
      end
    end
    result
  end

  private

  def place_pawns
    (0..7).each do |j|
      pos = [1, j]
      self[pos] = Pawn.new(pos, self, :black)
    end
    (0..7).each do |j|
      pos = [6, j]
      self[pos] = Pawn.new(pos, self, :white)
    end
  end

  def place_null_pieces
    (2..5).each do |i|
      (0..7).each do |j|
        pos = [i, j]
        self[pos] = NullPiece.instance
      end
    end
  end

  def place_capital_pieces
    place_rooks
    place_knights
    place_bishops
    place_queens
    place_kings
  end

  def place_rooks
    [0, 7].each do |i|
      self[[0, i]] = Rook.new([0, i], self, :black)
      self[[7, i]] = Rook.new([7, i], self, :white)
    end
  end

  def place_knights
    [1, 6].each do |i|
      self[[0, i]] = Knight.new([0, i], self, :black)
      self[[7, i]] = Knight.new([7, i], self, :white)
    end
  end


  def place_bishops
    [2, 5].each do |i|
      self[[0, i]] = Bishop.new([0, i], self, :black)
      self[[7, i]] = Bishop.new([7, i], self, :white)
    end
  end

  def place_queens
    self[[0, 3]] = Queen.new([0, 3], self, :black)
    self[[7, 3]] = Queen.new([7, 3], self, :white)
  end

  def place_kings
    self[[0, 4]] = King.new([0, 4], self, :black)
    self[[7, 4]] = King.new([7, 4], self, :white)
  end
end
