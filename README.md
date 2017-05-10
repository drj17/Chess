# Terminal Chess

A recreation of the classic game of chess using Ruby

## How to Run
1. Clone this repo
2. Run `ruby game.rb`
3. Follow the on-screen instructions

## Implementation

Terminal Chess leverages Object Oriented Programming paradigms to keep code DRY.  Each piece has Deltas describing their possible movement directions and the code block below can be used to generate moves for the piece.

```
def generate_moves
  moves = []
  DELTAS[self.color].each do |delta|
    next_pos = find_next_pos(self.pos, delta)
    if valid_move?(next_pos)
      moves << next_pos unless enemy_at?(next_pos)
    end
  end
  moves
end
```

Terminal chess also leverages duck typing to allow the human player and computer player classes to be swapped out seamlessly.  Both classes have a play_turn method that will handle the game logic that the game class can handle each players turns without any extra conditional logic.

Each Piece also has a method to check for valid moves that will reject any moves that would leave the player in check:

```
 def valid_moves
    potential_moves = self.moves
    potential_moves.reject! do |move|
      next_board = @board.dup
      next_board.move_piece(self.pos, move, false)
      next_board.in_check?(self.color)
    end
    potential_moves
  end
```
By utilizing the above method, Terminal Chess can check if a player is in checkmate if a player has no valid moves left:

```
def checkmate?(color)
  pieces = get_pieces(color)
  in_check?(color) && pieces.all? do |piece|
    piece.valid_moves.empty?
  end
end
```


Terminal Chess also has a simple AI that will capture the best piece available if any are in attacking range:

```
def capture_pieces(potential_moves)
  capture_moves = []
  potential_moves.each do |move|
    unless display.board[move[1]].is_a?(NullPiece)
      capture_moves << move
    end
  end
  capture_moves.sort { |a, b| display.board[b[1]].value <=> display.board[a[1]].value }
end

```


## Screenshots

An example of Terminal Chess utilizing check-mate logic:

![Checkmate](http://david-janas.com/img/portfolio/chess-full.png)

Terminal Chess uses the colorize gem for tile styling, allowing for a more enjoyable user experience:

![Usermove](http://i.imgur.com/PcHT5Kw.png)

## Todo

- [ ] Utilize the negamax or minimax algorithms with alpha-beta pruning for a more intelligent chess AI
