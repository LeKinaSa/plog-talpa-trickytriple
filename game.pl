
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
 *      Remove : x
 *      Others : l, r, u, d
 */
% move(+GameState, +Move, -NewGameState)
move(Dimensions-Board-PlayerOnMove, Column-Line-Movement, Dimensions-NewBoard-NextPlayer) :-
    Movement \= x,
    replace_on_board(Column-Line, ' ', Dimensions-Board, NewBoard),
    movement_position(Column-Line, Movement, NextColumn-NextLine),
    player_symbol(PlayerOnMove, Element),
    replace(NextColumn-NewLine, Element, Dimensions-Board, NewBoard),
    NextPlayer is -Player.

move(Dimensions-Board-PlayerOnMove, Column-Line-x, Dimensions-NewBoard-NextPlayer) :-
    replace(Column-Line, ' ', Dimensions-Board, NewBoard),
    NextPlayer is -Player.

/**
 * Calculates the cell to where the piece is going to be moved to
 * Movement:
 *      Up    : u - 117
 *      Down  : d - 100
 *      Left  : l - 108
 *      Right : r - 114
 */
% movement_position(+Cell, +Movement, -NewCell)
movement_position(Column-Line, 117, Column-NextLine) :-
    NextLine is Line + 1.

movement_position(Column-Line, 100, Column-NextLine) :-
    NextLine is Line - 1.

movement_position(Column-Line, 108, NextColumn-Line) :-
    NextColumn is Column - 1.

movement_position(Column-Line, 114, NextColumn-Line) :-
    NextColumn is Column + 1.

/**
 * Replace the Cell Value in Board for Element
 * BoardInfo = Dimensions-Board
 * In the board, Column goes from      1     to Dimensions
 *           and  Line  goes from Dimensions to      1
 */
% replace(+Cell, +Element, +BoardInfo, -NewBoard)
replace(Column-Line, Element, Dimensions-Board, NewBoard) :-
    replace_on_board(Column-Line, Dimensions, Element, Board, NewBoard).

/**
 * Replaces the TargetCell value for Element
 * Helper Function for replace/4
 */
% replace_on_board(+TargetCell, +CurrentLine, +Element, +Board, -NewBoard)
replace_on_board(TargetColumn-TargetLine, CurrentLine, Element, [Line | Board], [Line | NewBoard]) :-
    CurrentLine > TargetLine,
    NextLine is CurrentLine - 1,
    replace_on_board(TargetColumn-TargetLine, NextLine, Element, Board, NewBoard).

replace_on_board(TargetColumn-TargetLine, TargetLine, Element, [Line | Board], [NewLine | Board]) :-
    replace_on_line(TargetColumn, 1, Element, Line, NewLine).

/**
 * Replaces the TargetColumn cell value for Element
 * Helper Function for replace_on_board/5
 */
% replace_on_line(+TargetColumn, +CurrentColumn, +Element, +Line, -NewLine)
replace_on_line(TargetColumn, CurrentColumn, Element, [Cell | Line],  [Cell | NewLine]) :-
    CurrentColumn < TargetColumn,
    NextColumn is CurrentColumn - 1,
    replace_on_line(TargetColumn, NextColumn, Element, Line, NewLine).

replace_on_line(TargetColumn, TargetColumn, Element, [_ | Line], [Element | Line]).

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
% find_winner(+Paths, +PlayerOnMove, -Winner)
find_winner(0-0, _, 0).
find_winner(1-0, _, -1).
find_winner(0-1, _, +1).
find_winner(1-1, Player, Winner) :-
    Winner is -Player.

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
