require_relative 'display'

class NoPieceError < StandardError
end

class WrongColor < StandardError
end

class HumanPlayer

  attr_reader :name, :display, :cursor, :color

  def initialize(name, display, color)
    @color = color
    @name = name
    @display = display
    @cursor = display.cursor
  end

  def play_turn
    puts "#{name}'s turn!"
    start_pos = 0
    until start_pos.is_a?(Array)
      system("clear")
      puts "#{name}'s turn! Color is #{color}. Select a piece."
      display.render
      puts "Check!" if display.board.in_check?(color)
      start_pos = @cursor.get_input
    end
    raise WrongColor if display.board[start_pos].color != color
    raise NoPieceError if display.board[start_pos].is_a?(NullPiece)
    display.selected = start_pos
    end_pos = 0
    until end_pos.is_a?(Array)
      system("clear")
      puts "#{name}'s turn! Color is #{color}. Where to?"
      display.render
      puts "Check!" if display.board.in_check?(color)
      end_pos = @cursor.get_input
    end
    display.selected = nil
    return move = start_pos, end_pos
  end
end
