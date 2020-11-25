
/**
 --------------------------------------------------------------------------------
 --------------------               Valid Moves              --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Obtain All the Possible Valid Moves at a certain GameState
 */
% valid_moves(+GameState, +Player, -ListOfMoves)
valid_moves(GameState, _, PossibleMoves) :-
    valid_moves_by_moving_pieces(GameState, PossibleMovesByMoving),
    valid_moves_by_not_moving_pieces(GameState, PossibleMovesByMoving, PossibleMoves).

/**
 * Obtain All the Possible Valid Moves Obtained by Moving a Piece
 */
% valid_moves_by_moving_pieces(+GameState, -ListOfMoves)
valid_moves_by_moving_pieces(GameState, PossibleMoves) :-
    get_pieces_from_player(GameState, Pieces),
    obtain_moving_piece_moves(GameState, Pieces, PossibleMoves).

/**
 * Obtain All the Possible Valid Moves Obtained by NOT Moving a Piece
 *
 * If there's a possible move by moving a piece, there's no other valid moves.
 * Otherwise, we have to remove a piece.
 */
% valid_moves_by_not_moving_pieces(+GameState, +ListOfMovesByMoving, -ListOfMoves)
valid_moves_by_not_moving_pieces(GameState, PossibleMovesByMoving, PossibleMovesByRemovingPiece) :-
    length(PossibleMovesByMoving, 0),
    valid_moves_by_removing_pieces(GameState, PossibleMovesByRemovingPiece).

valid_moves_by_not_moving_pieces(_, PossibleMovesByMoving, PossibleMovesByMoving) :-
    length(PossibleMovesByMoving, L),
    L > 0.

/**
 * Obtain All the Possible Valid Moves Obtained by Removing a Piece
 */
% valid_moves_by_removing_pieces(+GameState, -ListOfMoves)
valid_moves_by_removing_pieces(GameState, PossibleMoves) :-
    get_pieces_from_player(GameState, Pieces),
    obtain_removing_piece_moves(Pieces, PossibleMoves).

/**
 * Obtain All Movements accordingly to the Positions of the Player's Pieces and the Enemy's Pieces
 */
% obtain_moving_piece_moves(+GameState, +Pieces, -ListOfMoves)
obtain_moving_piece_moves(GameState, Pieces, PossibleMoves) :-
    obtain_all_moving_piece_moves(GameState, Pieces, AllMoves),
    clear_invalid_moves(AllMoves, PossibleMoves).

/**
 * Remove all the invalid moves
 * Invalid Move : 0
 */
% clear_invalid_moves(+AllMoves, -ValidMoves)
clear_invalid_moves(AllMoves, ValidMoves) :-
    delete(AllMoves, 0, ValidMoves).

/**
 * Obtain All Movements (valid or invalid)
 */
% obtain_all_moving_piece_moves(+GameState, +Pieces, -ListOfMoves)
obtain_all_moving_piece_moves(GameState, [Piece | Pieces], [R, L, U, D | PossibleMoves]) :-
    obtain_piece_movement(GameState, Piece, r, R),
    obtain_piece_movement(GameState, Piece, l, L),
    obtain_piece_movement(GameState, Piece, u, U),
    obtain_piece_movement(GameState, Piece, d, D),
    obtain_all_moving_piece_moves(GameState, Pieces, PossibleMoves).

obtain_all_moving_piece_moves(_, [], []).

/**
 * Obtain the Movement Towards a Direction
 */
% obtain_piece_movement(+GameState, +Position, +Direction, -Move)
obtain_piece_movement(Dimensions-Board-Player, Position, Direction, Move) :-
    adjacent_cell(Position, Direction, Dimensions-Board, Element),
    obtain_move_from_element(Position, Direction, Player, Element, Move).

/**
 * Obtain the Move Accordingly to the Player
 * Invalid Move : 0
 */
% obtain_move_from_element(+Position, +Direction, +Player, +Element, -Move)
obtain_move_from_element(Position, Direction, Player, Element, Position-Direction) :-
    Enemy is -Player,
    player_symbol(Enemy, Element).

obtain_move_from_element(_, _, _, _, 0).

/**
 * Obtain All the Removing Moves accordingly to the Positions of the Player's Pieces
 */
% obtain_removing_piece_moves(+PlayerPieces, -ListOfMoves)
obtain_removing_piece_moves([Piece | Pieces], [Piece-x | PossibleMoves]) :-
    obtain_removing_piece_moves(Pieces, PossibleMoves).
obtain_removing_piece_moves([], []).

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
 --------------------                Next Move               --------------------
 --------------------------------------------------------------------------------
**/
/**
 * Choose the Next Move According to the Level
 * Move has to be a Valid Move
 * Levels:
 *      0 - Player
 *      1 - Random
 *      2 - Greedy
 */
% choose_move(+GameState, +Player, +Level, -Move)
choose_move(GameState, _, 0, Move) :-
    choose_player_move(GameState, Move).

choose_move(GameState, _, 1, Move) :-
    choose_ai_random_move(GameState, Move).

choose_move(GameState, _, 2, Move) :-
    choose_ai_greedy_move(GameState, Move).

/* ---------- Player Move ---------- */

/**
 * Choose the Next Move According to the Player
 */
% choose_player_move(+GameState, -Move)
choose_player_move(GameState, Move) :-
    valid_moves(GameState, _, ValidMoves),
    obtain_player_move(ValidMoves, Move).

/**
 * Obtain the Next Move from Player
 * Move has to be Valid
 */
% obtain_player_move(+ValidMoves, -Move)
obtain_player_move(ValidMoves, Move) :-
    obtain_move_input(Move),
    member(Move, ValidMoves).

obtain_player_move(ValidMoves, Move) :-
    obtain_player_move(ValidMoves, Move).

/**
 * Obtain Move Input
 */
% obtain_move_input(-Move)
obtain_move_input(Move) :-
    get_code(ColumnCode),
    get_code(LineCode),
    get_code(DirectionCode),
    skip_line,
    get_move(ColumnCode-LineCode-DirectionCode, Move).

/**
 * Obtain Move From Input Codes
 */
% get_move(+MoveCodes, -Move)
get_move(ColumnCode-LineCode-DirectionCode, Column-Line-Direction) :-
    get_column(ColumnCode, Column),
    get_line(LineCode, Line),
    get_direction(DirectionCode, Direction).

/**
 * Obtain Column From Input Code
 */
% get_column(+Code, -Column)
get_column(Code, Column) :-
    Code >= 65, % A
    Code =< 90, % Z
    Column is Code - 64.

get_column(Code, Column) :-
    Code >= 97,  % a
    Code =< 122, % z
    Column is Code - 96.

get_column(_, 0).

/**
 * Obtain Line From Input Code
 */
% get_line(+Code, -Line)
get_line(Code, Line) :-
    Code >= 49, % 1
    Code =< 57, % 9
    Line is Code - 48.

get_line(_, 0). % Default Error

/**
 * Obtain Direction From Input Code
 */
% get_direction(+Code, -Direction)
get_direction( 82, r). % R
get_direction(114, r). % r
get_direction( 76, l). % L
get_direction(108, l). % l
get_direction( 85, u). % U
get_direction(117, u). % u
get_direction( 68, d). % D
get_direction(100, d). % d
get_direction( 88, x). % X
get_direction(120, x). % x
get_direction(_, 0). % Default (Error)

/* ----------   AI   Move ---------- */

/**
 * Choose the Next Move According to the Random AI
 */
% choose_ai_random_move(+GameState, -Move)
choose_ai_random_move(GameState, Move) :-
    valid_moves(GameState, _, ValidMoves),
    random_member(Move, ValidMoves).

/**
 * Choose the Next Move According to the Greedy AI
 */
% choose_ai_greedy_move(+GameState, -Move)
choose_ai_greedy_move(_, _). /* TODO */