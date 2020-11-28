# PLOG_TP1_RI_T6_TALPA_2

## **Identification: T6 Talpa 2**
- Ângelo Daniel Pereira Mendes Moura (up201303828)
- Clara Alves Martins (up201806528)

## **Installation and Execution**
TODO

## **The TALPA Game**

### Objective

The goal of our game is to open a path of empty spaces between opposite sides with the same color without opening a similar route between the sides with the enemy color.

### Game Board

The gameboard is an 8x8 board. It can also be in 6x6 for beginners and faster games or 10x10 for experienced players and longer games.

The red player owns the top and bottom edges while the blue player owns the left and right ones.

The corner between edges is part of both sides.

### Game Start

At the start of the game, all the pieces are inside the gameboard. Their position is in such a pattern that there are no orthogonally adjacent pieces from the same player.

The starting player is red. 

### Rules

The turns alter, and the players move alternately.

When it is their turn, the player should move one of his pieces, capturing an enemy one, either horizontally adjacent or vertically adjacent, and leaving his in that spot.

If possible, the player must capture enemy pieces. However, when that is no longer possible, the player removes one of his own.

### Win Conditions

The only way to win is to connect orthogonally (horizontally or vertically, but not diagonally) adjacent empty squares to form a path between the player's sides without forming a similar route between the enemy's sides.

If a player opens a path between his sides in the same move/turn as a path between the enemy's sides, he loses.

There are no draws.

## **Game Logic**
TODO

### Game State Representation
The current game state is a composition of the Dimensions of the gameboard, the Board itself, and the next player to move.
It is a complex term implemented as ```Dimensions-Board-Player```.

The game board (```Board```) is a list of lists forming a square matrix of dimension ```Dimensions```.

In this matrix, each cell represents a cell of the gameboard and can have one of three values:
space (" ") representing an empty cell of the gameboard,
an upper case "x" ("X") representing a board cell occupied by a piece of the red player,
an upper case "o" ("O") representing a board cell occupied by a piece of the blue player.

The ```Player``` represents the player on the move. It can be either red, represented as 1, or blue, represented as -1.

### Game State Visualization
Before entering the game, the predicate ```display_menu/1``` will display some menus that allow the user to configure the game.
The game configurations cover the dimension of the game board and the type of game, and the level of artificial intelligence.

The predicate ```display_game/2``` handles the presentation of the game.

This predicate prints all the game state information on the screen.
This information includes the player on the move, and the current game board.

The game board is the most complex object. When printing it, the predicate ```display_game/2``` uses some auxiliary predicates that parse the list of lists that represent the gameboard internally.
These predicates go through each element of the main list, these being equivalent to the lines of the gameboard, printing each symbol of each cell on the screen; so that every piece in a board line appears on the same screen line, and each board line appears on a separate screen line.

During the board printing, some minor auxiliary predicates create dividers in the form of spaces (" "), slashes ("|"), and hyphens ("-"). These help in the readability of the gameboard once printed on the screen.

### Valid Moves
The predicate ```valid_moves/3``` obtains a list of possible and valid moves for
the player on the move.

Each move is a complex member with the form ```Column-Line-Movement```, in which ```Column-Line``` is  the cell the piece to be moved is located in and ```Movement``` takes 1 of possible 5 values, these being "l" - representing a left capturing movement, "r" - a right capturing movement, "u" - an up capturing movement, "d" - a down capturing movement and "x" - removing the piece form the board.  

First the predicate obtains the list of all possible moves that involve capturing a piece. This is done by locating all the pieces of the player on the move, then the predicate obtains all 4 possible moves of each piece (up, down, left, right) and finally it removes the moves that don't capture an opponent's piece.

If the list of moves that involve capturing a piece is empty. The predicate instead returns a list of moves that involve removing a piece of the board. This list is constructed by obtaining all the pieces of the player on the move from the board.

The move that a player or the computer will make must be within this list.

### Move
When moving, the predicate ```move/3``` will calculate the next game state based on the previous game state and the move made by the player or computer.

Since the move is represented by ```Column-Line-Movement```, the predicate obtains the cell ```Column-Line``` and replaced the symbol on it for a " ". If ```Movement``` is "x" the predicate ends. If not the predicate will obtain the ```Movement``` represented adjacent cell to ```Column-Line``` and replace the symbol on it (which is guaranteed to be the symbol of the player NOT on the move) with the symbol of the player on the move.   

### Game Over
The game ends when a path opens between two opposite sides. At this point, we can determine the winner, and the game ends.

To determine if the game is over, the predicate ```game_over/2``` is used. This predicate tries to find a path between the opposite's sides of the board. If a path is found between the top and bottom sides of the board, but not for the left and right sides, then the red player (1) is the winner, if the opposite is found then the blue player (-1) is the winner.
In the case where a path between the left and right sides is found alongside a path between the up and down sides, this can happen because the corners of the board count as belonging to both sides, then the player that just made a move is declared the loser.

### Board Value
In order for the computer to be able to choose the best move among a list of possible ones, it is required for it to compute the resulting board for a given move and compare that resulting board to others that result from other possible moves.

For this board comparison to be possible the predicate ```value/3``` is used to obtain a representative numerical value of the board. The better a board is for a given player the higher the numerical value will be. By choosing the move that results in the board that gives the highest value the computer is choosing the best possible move.  

The predicate ```value/3``` focuses on finding orthogonally grouped empty cells, referred as clusters. Once it has found one it projects the cluster onto an axis of the board, the vertical axis is used when evaluating a board for the red player (1) and the horizontal axis is for the blue player (-1). The numerical value of the board will be length of the biggest cluster projection of that board.

### Computer Move
The predicate ```choose_move/4``` is used to determine the next move. The ```Level``` argument in this predicate is used to determine the level of artificial intelligence.
- Level 0: Player Move (```choose_player_move/2```)
    The move is inputted by the player.
- Level 1: Random AI Move (```choose_ai_random_move/2```)
    The move is chosen at random from the list of possible moves.
- Level 2: Greedy AI Move (```choose_ai_greedy_move/2```)
    The best move is chosen from the list of possible moves. The moves being evaluated by the predicate ```value/3```.

## **Conclusions**
TODO : limitações do trabalho desenvolvido + possíveis melhorias identificadas
Melhoria: better AI

## **Bibliography**
- Official Game Page: https://nestorgames.com/#talpa_detail
- Rulebooks: http://www.iggamecenter.com/info/en/talpa.html , https://www.nestorgames.com/rulebooks/TALPA_EN.pdf
