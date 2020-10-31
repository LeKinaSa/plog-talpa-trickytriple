# PLOG_TP1_RI_T6_TALPA_2

## Identification : T6 Talpa 2
- Ângelo Daniel Pereira Mendes Moura (up201303828)
- Clara Alves Martins (up201806528)

## Game Description

### Objective

The goal of our game is to open a path of empty spaces between opposite sides with the same color without opening a similar route between the sides with the enemy color.

### Game Board

The gameboard is an 8x8 board or 6x6 for beginners and faster games.

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
- Oficial Game Page : https://nestorgames.com/#talpa_detail
- Rulebooks : http://www.iggamecenter.com/info/en/talpa.html , https://www.nestorgames.com/rulebooks/TALPA_EN.pdf


## Internal Game State
The current game state is the current board, the next player to move, and the number of captured pieces from both players.

### Board Representation
Our game board is a list and the dimension of a line.

### Current Player
The next player to move is either red or blue.

### Captured Pieces
We store the captured pieces in a list with two elements. The first being the number of red captured pieces and the second one being the number of blue captured pieces.

## Representation Examples

### Meaning of Piece Representation
Our pieces can be red represented as X, and blue as O.

### Initial Game State
(talpa 1)

### Intermediate Game State
(talpa 2)
(talpa 3)

### Final Game State
(talpa 4)

## Game Visualization
- Descrição da implementação do predicado de visualização do estado do jogo
- (até 200 palavras)
