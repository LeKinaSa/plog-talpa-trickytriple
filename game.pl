:- include('board.pl').
:- include('path_finder.pl').

/**
 --------------------------------------------------------------------------------
 --------------------               TALPA Game               --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Talpa Game
 * Dimensions = Size of the Board
 * Players    = RedBot-BlueBot
 * RedBot     = Red Bot
 * BlueBot    = Blue Bot
 * Bots:
 *      0 - Player
 *      1 - Random
 *      2 - Greedy
 * 
 * Game State = Dimensions-Board-Player
 * BoardInfo  = Dimensions-Board
 */
% talpa(+Dimensions, +Players)
talpa(Dimensions, _) :-
    initial(Dimensions-Board-Player),
    display_game(Dimensions-Board-Player, _).

/**
 --------------------------------------------------------------------------------
 --------------------                Game Over               --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Decides the Winner of the Game based on the Current GameState
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
