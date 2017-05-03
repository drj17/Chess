require_relative "board"
require_relative 'cursor'
require 'colorize'


class Display
  attr_reader :board, :cursor
  attr_accessor :selected
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
    @selected = nil
  end

  def render
    puts ""
    board.board.each_with_index do |row, i|
      row.each_with_index do |square, j|
          char = " " + square.to_s + " "
          if [i, j] == @cursor.cursor_pos
            print char.colorize(:color => :white, :background => :red)
          elsif selected && [i, j] == selected
            print char.colorize(:color => :white, :background => :green)
          elsif i.even? && j.odd? || i.odd? && j.even?
            print char.colorize(:background => :grey)
          elsif i.odd? && j.odd? || i.even? && j.even?
            print char.colorize(:background => :white)
          end
      end
      puts ""
    end
  end
end
