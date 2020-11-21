/**
 * Player Symbol
 * Red Player is X
 * Blue Player is O
 */
% player_symbol(+Player, -Symbol)
player_symbol(+ 1, 'X').
player_symbol(- 1, 'O').

/**
 * Replace element in Cell for NewElement
 */
% replace_on_board(+Cell, +NewElement, +Board, -NewBoard)
replace_on_board(Column-Line, Element, Board, NewBoard).

replace(Column-Line, C-L, Element, Board, NewBoard) :-
    L > Line,
    NewL is L - 1,
    replace(Column-Line, C-NewL, Element, Board, NewBoard).

replace(Column-Line, C-Line, Element, Board, NewBoard) :-
    C < Column,
    NewC is C + 1,
    replace(Column-Line, NewC-Line, Element, Board, NewBoard).

replace(Column-Line, Column-Line, Element, Board, NewBoard).


