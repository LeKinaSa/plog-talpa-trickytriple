/**
 --------------------------------------------------------------------------------
 --------------------              Player Symbol             --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Player Symbol
 * Red  Player (  1) is X
 * Blue Player (- 1) is O
 */
% player_symbol(+Player, -Symbol)
player_symbol(  1, 'X').
player_symbol(- 1, 'O').


/**
 --------------------------------------------------------------------------------
 --------------------                 Replace                --------------------
 --------------------------------------------------------------------------------
**/

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
    NextColumn is CurrentColumn + 1,
    replace_on_line(TargetColumn, NextColumn, Element, Line, NewLine).

replace_on_line(TargetColumn, TargetColumn, Element, [_ | Line], [Element | Line]).

/**
 --------------------------------------------------------------------------------
 --------------------        Position Inside the Board       --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Verifies if the Position is Inside the Board
 */
% inside_board(+Position, +Dimensions)
inside_board(Column-Line, Dimensions) :-
    Column > 0,
    Column =< Dimensions,
    Line > 0,
    Line =< Dimensions.

/**
 --------------------------------------------------------------------------------
 --------------------               Board Cell               --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Obtains the Element in the Cell
 * BoardInfo = Dimensions-Board
 *  Line  goes from Dimensions to      1
 * Column goes from      1     to Dimensions
 */
% board_cell(+Position, +BoardInfo, -Element)
board_cell(Column-Line, Dimensions-Board, Element) :-
    inside_board(Column-Line, Dimensions),
    LineNumber is Dimensions - Line + 1,
    nth1(LineNumber, Board, BoardLine),
    nth1(Column, BoardLine, Element).

board_cell(_, _, '-').

/**
 --------------------------------------------------------------------------------
 --------------------            Adjacent Position           --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Calculates the Position of the Adjacent Piece
 * Adjacency:
 *      Up    : u
 *      Down  : d
 *      Left  : l
 *      Right : r
 */
% adjacent_position(+Cell, +Adjacency, -NewCell)
adjacent_position(Column-Line, u, Column-NextLine) :-
    NextLine is Line + 1.

adjacent_position(Column-Line, d, Column-NextLine) :-
    NextLine is Line - 1.

adjacent_position(Column-Line, l, NextColumn-Line) :-
    NextColumn is Column - 1.

adjacent_position(Column-Line, r, NextColumn-Line) :-
    NextColumn is Column + 1.

/**
 --------------------------------------------------------------------------------
 --------------------              Adjacent Cell             --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Obtains the Adjacent Element
 * BoardInfo = Dimensions-Board
 * Element:
 *      ' ' - empty
 *      '-' - outside of board
 */
% adjacent_cell(+Position, +Adjacency, +BoardInfo, -Element)
adjacent_cell(Position, Adjacency, BoardInfo, Element) :-
    adjacent_position(Position, Adjacency, NextPosition),
    board_cell(NextPosition, BoardInfo, Element).

/**
 --------------------------------------------------------------------------------
 --------------------               Path Finder              --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Checks if a path exists between the red edges (up and down)
 * BoardInfo = Dimensions-Board
 * Return Values:
 *          0 - no path
 *          1 - path
 */
% find_path_red_red(+BoardInfo, -Path)
find_path_red_red(Dimensions-Board, 1) :-
    find_path_up_down(Dimensions-Board).

/**
 * Tries to find a path between the edges UP and DOWN
 */
% find_path_up_down(+BoardInfo)
find_path_up_down(_).

/**
 * Checks if a path exists between the blue edges (left and right)
 * BoardInfo = Dimensions-Board
 * Return Values:
 *          0 - no path
 *          1 - path
 */
% find_path_blue_blue(+BoardInfo, -Path)
find_path_blue_blue(Dimensions-Board, 1) :-
    find_path_left_right(Dimensions-Board).

/**
 * Tries to find a path between the edges LEFT and RIGHT
 */
% find_path_left_right(+BoardInfo)
find_path_left_right(_).
