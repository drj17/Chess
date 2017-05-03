require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false
    STDIN.raw!
    input = STDIN.getc.chr

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true
    STDIN.cooked!

    input
  end

  def handle_key(key)
    case key
    when :return, :space
      return self.cursor_pos.dup
    when :left
      update_pos(MOVES[:left])
    when :right
      update_pos(MOVES[:right])
    when :up
      update_pos(MOVES[:up])
    when :down
      update_pos(MOVES[:down])
    when :ctrl_c
      Process.exit(0)
    end
  end

  def update_pos(diff)
    new_x = @cursor_pos[0] + diff[0]
    new_y = @cursor_pos[1] + diff[1]
    if board.in_bounds?([new_x, new_y])
      @cursor_pos[0] = new_x
      @cursor_pos[1] = new_y
    end
  end
end
