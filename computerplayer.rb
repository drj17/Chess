require_relative 'display'
require 'byebug'

class ComputerPlayer

  attr_reader :name, :display, :cursor, :color
  attr_accessor :first_turn, :potential_moves

  def initialize(name, display, color)
    @color = color
    @name = name
    @display = display
    @first_turn = true
    @potential_moves = []
  end

  def generate_moves(board)
    pieces = board.get_pieces(:black)

    pieces.each do |piece|
      start_pos = piece.pos
      piece.valid_moves.each do |move|
        @potential_moves << [start_pos, move]
      end
    end
  end

  def play_turn
    if @first_turn
      @first_turn = false
      return [[1, 4], [2, 4]]
    else
      generate_moves(display.board)
    end
    if !capture_pieces(@potential_moves).empty?
      return capture_pieces(@potential_moves).sample
    else
      return @potential_moves.sample
    end
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

  def get_best_move
    max_score = -Float::INFINITY
    optimal_move = nil
    generate_moves(display.board, :black).each do |move|
      p move
      score = negamax(
      display.board,
      2,
      -Float::INFINITY,
      Float::INFINITY,
      false
      )
      if score > max_score
        optimal_move = move
        max_score = score
      end
    end

    optimal_move
  end

  def negamax(board, depth, alpha, beta, maximizing_player)
    if depth == 0 || board.checkmate?(:black) || board.checkmate?(:white)
      return evaluate(board)
    end
    if maximizing_player
      max = -Float::INFINITY
      generate_moves(board, :white).each do |move|
        next_board = board.dup
        next_board.move_piece(move.first, move.last)
        max = [max, negamax(next_board, depth - 1, alpha, beta, false)].max
        alpha = [alpha, max].max
        if beta <= alpha
          break
        end
      end
      return max
    else
      max = Float::INFINITY
      generate_moves(board, :black).each do |move|
        next_board = board.dup
        next_board.move_piece(move.first, move.last)
        max = [max, negamax(next_board, depth - 1, alpha, beta, true)].min
        beta = [beta, max].min
        if beta <= alpha
          break
        end
      end
      return max
    end
  end

  def evaluate(board)
    if board.checkmate?(:black)
      return -Float::INFINITY
    end

    white_score = 0
    black_score = 0

    board.get_pieces(:white).each do |piece|
      white_score += piece.value
    end
    board.get_pieces(:black).each do |piece|
      black_score += piece.value
    end
    p black_score
    p white_score
    black_score - white_score
  end
end
