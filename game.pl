
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
    

