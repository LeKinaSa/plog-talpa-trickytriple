
:- include('board.pl').
/**
 * Game State = Dimensions-Board
 */
talpa(Dimensions, RedBot-BlueBot).


/**
 --------------------------------------------------------------------------------
 --------------------                Movement                --------------------
 --------------------------------------------------------------------------------
**/
/**
 * Moves a Piece
 * GameState = Dimensions-Board-Player
 * Movement:
 *      x - 120
 *      u - 
 */
% move(+GameState, +Move, -NewGameState)
move(Dimensions-Board-PlayerOnMove, Column-Line-Movement, Dimensions-NewBoard-NextPlayer) :-
    Movement \= x,
    replace_on_board(Column-Line, ' ', Board, NewBoard),
    movement_position(Column-Line, Movement, NextColumn-NextLine),
    player_symbol(PlayerOnMove, Element),
    replace_on_board(NextColumn-NewLine, Element, Board, NewBoard),
    NextPlayer is -Player.

move(Dimensions-Board-PlayerOnMove, Column-Line-120, Dimensions-NewBoard-NextPlayer) :-
    replace_on_board(Column-Line, ' ', Board, NewBoard),
    NextPlayer is -Player.

movement_position(Column-Line, 120, NextColumn-NextLine).
    


/**
 --------------------------------------------------------------------------------
 --------------------                Game Over               --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Decides the Winner of the Game based on the Current GameState
 * In this particular function,
 * GameState = Dimensions-Board-PlayerOnMove
 * 
 * Winner:
 *        0 -> not gameover yet
 *        1 -> red  player wins
 *      - 1 -> blue player wins
 */
% game_over(+GameState, -Winner)
game_over(Dimensions-Board-PlayerOnMove, Winner) :-
    find_path_blue_blue(Dimensions-Board, BluePath),
    find_path_red_red(Dimensions-Board, RedPath),
    find_winner(BluePath-RedPath, PlayerOnMove, Winner).

/**
 * Choose the Winner based on the Existing Path Between the Edges
 */
% find_winner(+Paths,+PlayerOnMove, -Winner)
find_winner(0-0, _, 0).
find_winner(1-0, _, -1).
find_winner(0-1, _, +1).
find_winner(1-1, Player, Winner) :- Winner is -Player. % TODO : see if i can make (1-1, Player, -Player)

/**
 * Checks if a path exists between the red edges (up and down)
 * Return Values:
 *          0 - no path
 *          1 - path
 */
% find_path_red_red(+GameState, -Path)
find_path_red_red(Dimensions-Board, 1) :-
    find_red_paths(Dimensions-Board).
find_path_red_red(Dimensions-Board, 0).

find_red_paths(Dimensions-Board).

/**
 * Checks if a path exists between the blue edges (left and right)
 * Return Values:
 *          0 - no path
 *          1 - path
 */
% find_path_blue_blue(+GameState, -Path)
find_path_blue_blue(Dimensions-Board, 1) :-
    find_blue_paths(Dimensions-Board).
find_path_blue_blue(Dimensions-Board, 0).

find_blue_paths(Dimensions-Board).
