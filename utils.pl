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
% board_cell(+Position, +BoardInfo, ?Element)
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
 --------------------              Player Pieces             --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Obtain All the Pieces' Positions on the Board from the Player
 *  Line  goes from Dimensions to      1
 * Column goes from     1     to Dimensions
 */
% get_pieces_from_player(+GameState, -Pieces)
get_pieces_from_player(Dimensions-Board-Player, Pieces) :-
    player_symbol(Player, PlayerSymbol),
    get_pieces_from_player(Dimensions, Board, PlayerSymbol, [], Pieces).

/**
 * Obtain the Line for the Piece's Positions
 */
% get_pieces_from_player_on_board(+Line, +Board, +PlayerSymbol, +Pieces, -NewPieces)
get_pieces_from_player_on_board(Line, [BoardLine | Board], PlayerSymbol, Pieces, NewPieces) :-
    get_pieces_from_player_on_line(1-Line, BoardLine, PlayerSymbol, Pieces, AuxPieces),
    NextLine is Line - 1,
    get_pieces_from_player_on_board(NextLine, Board, PlayerSymbol, AuxPieces, NewPieces).

/**
 * Obtain the Column for the Piece's Positions
 */
% get_pieces_from_player_on_line(+Position, +BoardLine, +PlayerSymbol, +Pieces, -NewPieces)
get_pieces_from_player_on_line(Column-Line, [PlayerSymbol | BoardLine],
                                PlayerSymbol, Pieces, [Column-Line | NewPieces]) :-
    NextColumn is Column + 1,
    get_pieces_from_player_on_line(NextColumn-Line, BoardLine, PlayerSymbol, Pieces, NewPieces).

get_pieces_from_player_on_line(Column-Line, [Element | BoardLine],
                                PlayerSymbol, Pieces, NewPieces) :-
    Element \= PlayerSymbol,
    NextColumn is Column + 1,
    get_pieces_from_player_on_line(NextColumn-Line, BoardLine, PlayerSymbol, Pieces, NewPieces).

get_pieces_from_player_on_line(_, [], Pieces, Pieces).

/**
 --------------------------------------------------------------------------------
 --------------------               Path Finder              --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Creates a Visited Board
 *          0 - not visited
 *          1 - visited
 */
% create_visited_board(+Line, +Dimensions, -Visited)
create_visited_board(Line, Dimensions, [BoardLine | Visited]) :-
    Line > 0,
    create_visited_line(Dimensions, BoardLine),
    NextLine is Line - 1,
    create_visited_board(NextLine, Dimensions, Visited).

create_visited_board(0, _, []).

/**
 * Creates a Visited Line
 */
% create_visited_line(+Column, -VisitedLine)
create_visited_line(Column, [0 | Line]) :-
    Column > 0,
    NextColumn is Column - 1,
    create_visited_line(NextColumn, Line).

create_visited_line(0, []).

/**
 * Checks if a Path exists between the Red Edges (up and down)
 * BoardInfo = Dimensions-Board
 * Return Values:
 *          0 - no path
 *          1 - path
 */
% find_path_red_red(+BoardInfo, -Path)
find_path_red_red(Dimensions-Board, 1) :-
    create_visited_board(Dimensions, Dimensions, Visited),
    find_red_path(1, Dimensions, Board, Visited).

find_path_red_red(_, 0).

/**
 * Finds a Path between Red Edges
 */
% find_red_path(+Column, +Dimensions, +Board, +Visited)
find_red_path(Column, Dimensions, Board, Visited) :-
    Column =< Dimensions,
    find_path_up_down(Column-Dimensions, Dimensions, Board, Visited).

find_red_path(Column, Dimensions, Board, Visited) :-
    NextColumn is Column + 1,
    find_red_path(NextColumn, Dimensions, Board, Visited).

/**
 * Tries to Find a Path between the Edges UP and DOWN
 */
% find_path_up_down(+Cell, +Dimensions, +Board, +Visited)
find_path_up_down(Cell, Dimensions, Board, Visited) :-
    board_cell(Cell, Dimensions-Board, ' '),
    board_cell(Cell, Dimensions-Visited, 0),
    replace(Cell, 1, Dimensions-Visited, NextVisited),
    find_path_up_down_adjacent(Cell, Dimensions, Board, NextVisited).

find_path_up_down(_-1, _, _, _).

/**
 * Tries to find a UP-DOWN Path through All the Adjacent Positions
 */
% find_path_up_down_adjacent(+Cell, +Dimensions, +Board, +Visited)
find_path_up_down_adjacent(Cell, Dimensions, Board, Visited) :-
    adjacent_position(Cell, r, NextCell),
    find_path_up_down(NextCell, Dimensions, Board, Visited).

find_path_up_down_adjacent(Cell, Dimensions, Board, Visited) :-
    adjacent_position(Cell, l, NextCell),
    find_path_up_down(NextCell, Dimensions, Board, Visited).

find_path_up_down_adjacent(Cell, Dimensions, Board, Visited) :-
    adjacent_position(Cell, u, NextCell),
    find_path_up_down(NextCell, Dimensions, Board, Visited).

find_path_up_down_adjacent(Cell, Dimensions, Board, Visited) :-
    adjacent_position(Cell, d, NextCell),
    find_path_up_down(NextCell, Dimensions, Board, Visited).

/**
 * Checks if a Path exists between the Blue Edges (left and right)
 * BoardInfo = Dimensions-Board
 * Return Values:
 *          0 - no path
 *          1 - path
 */
% find_path_blue_blue(+BoardInfo, -Path)
find_path_blue_blue(Dimensions-Board, 1) :-
    create_visited_board(Dimensions, Dimensions, Visited),
    find_blue_path(1, Dimensions, Board, Visited).

find_path_blue_blue(_, 0).

/**
 * Finds a Path between Blue Edges
 */
% find_blue_path(+BoardInfo)
find_blue_path(Line, Dimensions, Board, Visited) :-
    Line =< Dimensions,
    find_path_left_right(1-Line, Dimensions, Board, Visited).

find_blue_path(Column, Dimensions, Board, Visited) :-
    NextLine is Line + 1,
    find_blue_path(NextLine, Dimensions, Board, Visited).


/**
 * Tries to Find a Path between the Edges LEFT and RIGHT
 */
% find_path_left_right(+Cell, +Dimensions, +Board, +Visited)
find_path_left_right(Cell, Dimensions, Board, Visited) :-
    board_cell(Cell, Dimensions-Board, ' '),
    board_cell(Cell, Dimensions-Visited, 0),
    replace(Cell, 1, Dimensions-Visited, NextVisited),
    find_path_left_right_adjacent(Cell, Dimensions, Board, NextVisited).

find_path_left_right(Dimensions-_, Dimensions, _, _).

/**
 * Tries to find a LEFT-RIGHT Path through All the Adjacent Positions
 */
% find_path_left_right_adjacent(+Cell, +Dimensions, +Board, +Visited)
find_path_left_right_adjacent(Cell, Dimensions, Board, Visited) :-
    adjacent_position(Cell, r, NextCell),
    find_path_left_right(NextCell, Dimensions, Board, Visited).

find_path_left_right_adjacent(Cell, Dimensions, Board, Visited) :-
    adjacent_position(Cell, l, NextCell),
    find_path_left_right(NextCell, Dimensions, Board, Visited).

find_path_left_right_adjacent(Cell, Dimensions, Board, Visited) :-
    adjacent_position(Cell, u, NextCell),
    find_path_left_right(NextCell, Dimensions, Board, Visited).

find_path_left_right_adjacent(Cell, Dimensions, Board, Visited) :-
    adjacent_position(Cell, d, NextCell),
    find_path_left_right(NextCell, Dimensions, Board, Visited).
