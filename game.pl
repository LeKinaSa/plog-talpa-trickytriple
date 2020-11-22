:- include('board.pl').

/**
 * Game State = Dimensions-Board
 */
talpa(Dimensions, RedBot-BlueBot).

/**
 --------------------------------------------------------------------------------
 --------------------               Valid Moves              --------------------
 --------------------------------------------------------------------------------
**/
% valid_moves(+GameState, +Player, -ListOfMoves)
valid_moves(Dimensions-Board-Player, _, PossibleMoves).

/**
 --------------------------------------------------------------------------------
 --------------------              Move a Piece              --------------------
 --------------------------------------------------------------------------------
**/
/**
 * Moves a Piece
 * GameState = Dimensions-Board-Player
 * Movement:
 *      Remove : x
 *      Others : l, r, u, d
 */
% move(+GameState, +Move, -NewGameState)
move(Dimensions-Board-Player, Column-Line-Movement, Dimensions-NewBoard-NextPlayer) :-
    Movement \= x,
    replace(Column-Line, ' ', Dimensions-Board, AuxBoard),
    adjacent_position(Column-Line, Movement, NextColumn-NextLine),
    player_symbol(Player, Element),
    replace(NextColumn-NextLine, Element, Dimensions-AuxBoard, NewBoard),
    NextPlayer is -Player.

move(Dimensions-Board-Player, Column-Line-x, Dimensions-NewBoard-NextPlayer) :-
    replace(Column-Line, ' ', Dimensions-Board, NewBoard),
    NextPlayer is -Player.

/**
 --------------------------------------------------------------------------------
 --------------------                Game Over               --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Decides the Winner of the Game based on the Current GameState
 * In this particular function,
 * GameState = Dimensions-Board-Player
 * 
 * Winner:
 *        0 -> not gameover yet
 *        1 -> red  player wins
 *      - 1 -> blue player wins
 */
% game_over(+GameState, -Winner)
game_over(Dimensions-Board-PlayerOnMove, Winner) :-
    find_path_left_right(Dimensions-Board, BluePath),
    find_path_up_down(Dimensions-Board, RedPath),
    find_winner(BluePath-RedPath, PlayerOnMove, Winner).

/**
 * Choose the Winner based on the Existing Path Between the Edges
 */
% find_winner(+Paths, +PlayerOnMove, -Winner)
find_winner(0-0, _,  0).
find_winner(1-0, _, -1).
find_winner(0-1, _,  1).
find_winner(1-1, Player, Winner) :-
    Winner is -Player.
