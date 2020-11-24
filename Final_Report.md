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

At the start of the game, all the pieces are inside the board. Their position is in such a pattern that there are no orthogonally adjacent pieces from the same player.

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
TODO : baseado no relatório intercalar (atenção : GameState = Dimensions-Board-Player)

## Game State Visualization
TODO : baseado no relatório intercalar + menus

## Valid Moves
TODO

## Move
TODO

## Game Over
TODO

## Board Value
TODO

## Computer Move
TODO

## **Conclusions**
TODO : limitações do trabalho desenvolvido + possíveis melhorias identificadas
Melhoria : melhor AI

## **Bibliography**
- Official Game Page: https://nestorgames.com/#talpa_detail
- Rulebooks: http://www.iggamecenter.com/info/en/talpa.html , https://www.nestorgames.com/rulebooks/TALPA_EN.pdf
