require_relative 'board'
require_relative 'display'
require_relative 'player'
require_relative 'computerplayer'
require 'byebug'

class Game

  attr_reader :player1, :player2, :board, :display
  attr_accessor :current_player

  def initialize(name1, name2, against_computer)
    @board = Board.new
    @display = Display.new(@board)
    if against_computer == "y"
      @player1 = HumanPlayer.new(name1, @display, :white)
      @player2 = ComputerPlayer.new("Computer", @display, :black)
    else
      @player1 = HumanPlayer.new(name1, @display, :white)
      @player2 = HumanPlayer.new(name2, @display, :black)
    end
    @current_player = @player1
  end

  def play
    until board.checkmate?(current_player.color)
      begin
        move = current_player.play_turn
        board.move_piece(move[0], move[1], current_player.color)
      rescue NoPieceError
        puts "No piece selected."
        sleep(1)
        retry
      rescue InvalidMove
        puts "Invalid move."
        sleep(1)
        retry
      rescue WrongColor
        puts "Incorrect color selected."
        sleep(1)
        retry
      end
      switch_players!
    end
    system "clear"
    display.render
    case current_player
    when player1
      puts "Checkmate! #{player2.name} wins!"
    when player2
      puts "Checkmate! #{player1.name} wins!"
    end
  end

  def switch_players!
    current_player == player1 ? self.current_player = player2 : self.current_player = player1
  end
end
if __FILE__ == $PROGRAM_NAME
  puts "Would you like to play against the computer? (y,n)"
  input = gets.chomp
  g = Game.new("Player1", "Player2", input)
  g.play
end
