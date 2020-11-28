# PLOG_TP1_RI_T6_TALPA_2

## **Identification: T6 Talpa 2**
- Ângelo Daniel Pereira Mendes Moura (up201303828)
- Clara Alves Martins (up201806528)

## **Installation and Execution**
TODO

## **The TALPA Game**

## Objective

The goal of our game is to open a path of empty spaces between opposite sides with the same color without opening a similar route between the sides with the enemy color.

## Game Board

The gameboard is an 8x8 board. It can also be in 6x6 for beginners and faster games or 10x10 for experienced players and longer games.

The red player owns the top and bottom edges while the blue player owns the left and right ones.

The corner between edges is part of both sides.

## Game Start

At the start of the game, all the pieces are inside the gameboard. Their position is in such a pattern that there are no orthogonally adjacent pieces from the same player.

The starting player is red. 

## Rules

The turns alter, and the players move alternately.

When it is their turn, the player should move one of his pieces, capturing an enemy one, either horizontally adjacent or vertically adjacent, and leaving his in that spot.

If possible, the player has to capture enemy pieces. However, when that is no longer possible, the player removes one of his own.

## Win Conditions

The only way to win is to connect orthogonally (horizontally or vertically, but not diagonally) adjacent empty squares to form a path between the player's edges without forming a similar route between the enemy's sides.

If a player opens a path between his edges in the same move/turn as a path between the enemy's sides, he loses.

There are no draws.

## **Game Logic**
TODO

## Game State Representation
The current game state is a composition of the Dimensions of the gameboard, the Board itself, and the next player to move.
It is a complex term implemented as ```Dimensions-Board-Player```.

The game board (```Board```) is a list of lists forming a square matrix of dimension ```Dimensions```.

In this matrix, each cell represents a cell of the gameboard and can have one of three values:
space (" ") representing an empty cell of the gameboard,
an upper case "x" ("X") representing a board cell occupied by a piece of the red player,
an upper case "o" ("O") representing a board cell occupied by a piece of the blue player.

The ```Player``` represents the player on the move. It can be either red, represented as 1, or blue, represented as -1.

## Game State Visualization
Before entering the game, the predicate ```display_menu/1``` will display some menus that allow the user to configure the game.
The game configurations cover the dimension of the game board and the type of game, and the level of artificial intelligence.

The predicate ```display_game/2``` handles the presentation of the game.

This predicate prints all the game state information on the screen.
This information includes the player on the move, and the current game board.

The game board is the most complex object. When printing it, the predicate ```display_game/2``` uses some auxiliary predicates that parse the list of lists that represent the gameboard internally.
These predicates go through each element of the main list, these being equivalent to the lines of the gameboard, printing each symbol of each cell on the screen; so that every piece in a board line appears on the same screen line, and each board line appears on a separate screen line.

During the board printing, some minor auxiliary predicates create dividers in the form of spaces (" "), slashes ("|"), and hyphens ("-"). These help in the readability of the gameboard once printed on the screen.

## Valid Moves
The predicate ```valid_moves/3``` obtains a list of possible and valid moves.
TODO: It is only possible to remove a piece if there is no way of moving any of the pieces inside the gameboard.
The move that a player or the computer will make must be within this list.

## Move
When moving, the predicate ```move/3``` will calculate the next game state based on the previous game state and the move made by the player or computer.

## Game Over
The game ends when a path opens between two opposite edges. At this point, we can determine the winner, and the game ends.
TODO: If the path is between the upper and lower edges (aka the red edges), the red player wins.
If the path is between the left and right edges (aka the blue edges), the blue player wins.
However, if there's an open path both between red and blue edges, the player that opened them loses.

## Board Value
TODO

## Computer Move
The predicate ```choose_move/4``` is used to determine the next move. The ```Level```argument in this predicate is used to determine the level of artificial intelligence.
- Level 0: Player Move (```choose_player_move/2```)
- Level 1: Random AI Move (```choose_ai_random_move/2```)
- Level 2: Greedy AI Move (```choose_ai_greedy_move/2```)

## **Conclusions**
TODO : limitações do trabalho desenvolvido + possíveis melhorias identificadas
Melhoria: better AI

## **Bibliography**
- Official Game Page: https://nestorgames.com/#talpa_detail
- Rulebooks: http://www.iggamecenter.com/info/en/talpa.html , https://www.nestorgames.com/rulebooks/TALPA_EN.pdf
