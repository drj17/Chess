require_relative 'display'

class ComputerPlayer

  attr_reader :name, :display, :cursor, :color

  def initialize(name, display, color)
    @color = color
    @name = name
    @display = display
  end

  def play_turn
    potential_moves = generate_moves
    capture_moves = capture_pieces(potential_moves)

    if !capture_moves.empty?
      return capture_moves.sample
    end
    potential_moves.sample
  end

  def generate_moves
    pieces = display.board.get_pieces(color)
    moves = []

    pieces.each do |piece|
      start_pos = piece.pos
      piece.valid_moves.each do |move|
        moves << [start_pos, move]
      end
    end
    moves
  end

  def capture_pieces(potential_moves)
    capture_moves = []
    potential_moves.each do |move|
      unless display.board[move[1]].is_a?(NullPiece)
        capture_moves << move
      end
    end
    capture_moves.sort do |a, b|
      display.board[b[1]].value <=> display.board[a[1]].value
    end
  end
end
