# PLOG_TP1_RI_T6_TALPA_2

## Identification: T6 Talpa 2
- Ângelo Daniel Pereira Mendes Moura (up201303828)
- Clara Alves Martins (up201806528)

## Game Description

### Objective

The goal of our game is to open a path of empty spaces between opposite sides with the same color without opening a similar route between the sides with the enemy color.

### Game Board

The gameboard is an 8x8 board. It can also be in 6x6 for beginners and faster games or 10x10 for experienced players and longer games.

The red player owns the top and bottom edges while the blue player owns the left and right ones.

The corner between edges is part of both sides.

### Game Start

At the start of the game, all the pieces are inside the board. Their position is in such a pattern that there are no orthogonally adjacent pieces from the same player.

The starting player is red. 

### Rules

The turns alter, and the players move alternately.

When it is their turn, the player should move one of his pieces, capturing an enemy one, either horizontally adjacent or vertically adjacent, and leaving his in that spot.

If possible, the player has to capture enemy pieces. However, when that is no longer possible, the player removes one of his own.

### Win Conditions

The only way to win is to connect orthogonally (horizontally or vertically, but not diagonally) adjacent empty squares to form a path between the player's edges without forming a similar route between the enemy's sides.

If a player opens a path between his edges in the same move/turn as a path between the enemy's sides, he loses.

There are no draws.

### References
- Official Game Page: https://nestorgames.com/#talpa_detail
- Rulebooks: http://www.iggamecenter.com/info/en/talpa.html , https://www.nestorgames.com/rulebooks/TALPA_EN.pdf

## Internal Game State
The current game state is composed of the Dimensions of the board, the Board itself, and the number of captured pieces from both players. It is a complex member implemented as "Dimensions-Board-CapturedPieces".

### Board Representation
The game board ("Board" in the complex member representing the Game State) is a list of lists
forming a square matrix of dimension "Dimensions" (present in the member Game State).

In this matrix, each cell represents a cell of the board and can have one of three values: space (" ") representing an empty cell of the board, an upper case "x" ("X") representing a board cell occupied by a piece of the red player, an upper case "o" ("O") representing a board cell occupied by a piece of the blue player.

### Current Player
The player on the move accompanies the game state. This player can either be "red" or "blue".

### Captured Pieces
The Captured Pieces are a list with two elements that work as counters.

The first element is the number of pieces captured by the "red" player, and the second one is the number of pieces captured by the "blue" player.

## Representation Examples

### Meaning of Piece Representation
Pieces represented with an "X" belong to the "red" player, and the ones with an "O" belong to the "blue" player.

### Initial Game State
(Game State is "Dimensions-Board-CapturedPieces")

#### Can be visualized with "talpa(1)."

```
8-[ ['O','X','O','X','O','X','O','X'],
    ['X','O','X','O','X','O','X','O'],
    ['O','X','O','X','O','X','O','X'],
    ['X','O','X','O','X','O','X','O'],
    ['O','X','O','X','O','X','O','X'],
    ['X','O','X','O','X','O','X','O'],
    ['O','X','O','X','O','X','O','X'],
    ['X','O','X','O','X','O','X','O']
]-[0, 0]
```

### Intermediate Game State
(Game State is "Dimensions-Board-CapturedPieces")

#### Can be visualized with "talpa(2)."

```
8-[ ['O','X','O',' ','X','X','O','X'],
    ['X','O',' ','X','X',' ','X','O'],
    [' ','O',' ',' ',' ',' ','O','X'],
    ['X','O',' ','X','X','O','X','O'],
    [' ','O',' ',' ','O','O','O','O'],
    ['O','O','X',' ',' ',' ','X',' '],
    [' ','X','O',' ','X',' ','O','O'],
    ['X','O','X','X',' ','X','X',' ']
]-[11, 10]
```

#### Can be visualized with "talpa(3)."

```
8-[ ['X',' ','X',' ','X',' ','O',' '],
    [' ','O',' ','X','X',' ','O',' '],
    [' ','O',' ',' ',' ',' ',' ','O'],
    ['O',' ',' ','O',' ',' ',' ',' '],
    [' ','O',' ',' ','X',' ',' ','O'],
    ['O',' ',' ',' ',' ',' ','X',' '],
    [' ','X','O',' ','X',' ','O',' '],
    [' ','O',' ','X',' ','X',' ',' ']
]-[20, 20]
```

### Final Game State
(Game State is "Dimensions-Board-CapturedPieces")

#### Can be visualized with "talpa(4)."

```
8-[ ['X',' ','X',' ','X',' ','O',' '],
    [' ','O',' ','X','X',' ','O',' '],
    [' ','O',' ',' ',' ',' ',' ','O'],
    ['O',' ',' ','O',' ',' ',' ',' '],
    [' ','O',' ',' ','X',' ',' ','O'],
    ['O',' ',' ',' ',' ',' ',' ',' '],
    [' ','X','O',' ','X',' ','X',' '],
    [' ','O',' ','X',' ','X',' ',' ']
]-[21, 20]
```

## Game Visualization
The predicate display_game/2 handles the presentation of the game.

This predicate prints all the game state information on the screen. This information includes the player on the move, the pieces captured until that point, and the current game board.

The game board is the most complex object. When printing it, the predicate display_game uses some auxiliary predicates that parse the list of lists that represent the board internally. These predicates go through each element of the main list, these being equivalent to the lines of the board, printing each symbol of each cell on the screen; every piece in a board line appears on the same screen line, and each board line appears on a separate screen line.

During the board printing, some minor auxiliary predicates create dividers in the form of spaces (" "), slashes ("|"), and hyphens ("-"). These help in the readability of the board once printed on the screen. 
