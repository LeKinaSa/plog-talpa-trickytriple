:- use_module(library(clpfd)).
:- use_module(library(lists)).

:- ensure_loaded('puzzle_library.pl').
:- ensure_loaded('puzzle_solutions.pl').
:- ensure_loaded('display.pl').

/**
 * Main solver predicate of tricky triple puzzles.
 * A puzzle is uniquely identified by (Difficulty, Id),
 *    check file "puzzle_library.pl" for the full list of puzzles and 
 *    file "puzzle_solutions.pl" for the respective solutions.
 *
 *
 * Difficulty -> directly connected to the dimensions of the puzzle
 *       1 - 4x4
 *       2 - 5x5
 *       3 - 6x6
 *       4 - 7x7
 *
 * Id -> numeric identifier of puzzle instance within a difficulty
 *
 * LabelingOptions -> list of options to be used on labeling
 *
 * PuzzleSolution -> a solved board
**/
% solver(+Difficulty, +Id, +LabelingOptions, -PuzzleSolution) 
solver(Difficulty, Id, LabelingOptions, Board):-
    puzzle(Difficulty, Id, Board),
    flatten(Board, BoardList),
    domain(BoardList, 0, 3),
    
    apply_non_zero_constraint(BoardList),
    findall(SequentialTriple, sequential_triple(Board, SequentialTriple), ListOfSequentialTriples),
    apply_triple_constraint(Board, ListOfSequentialTriples),

    labeling(LabelingOptions, BoardList).

/**
 * -------------------------------------------------------------------------------
 * -----   Predicates that Discover All Groups of 3 Adjacent White Squares   -----
 * -------------------------------------------------------------------------------
**/

/**
 * Verifies that Triple is representing a group of 3 Adjacent White Squares on the board Board.
 * This predicate is used in a findall to get all groups of 3 adjacent white squares.
 *
 * Board -> the puzzle board
 *
 * Triple -> a list of 3 elements with type X-Y. If valid, X-Y are coordinates of a board cell.
**/
% sequential_triple(+Board, +Triple)

/* Vertical Triple */
sequential_triple(Board, [X1-Y1, X2-Y2, X3-Y3]):-
    all_valid_white_cells(Board, [X1-Y1, X2-Y2, X3-Y3]),
    X1 =:= X2 - 1,
    X1 =:= X3 - 2,
    Y1 =:= Y2,
    Y2 =:= Y3.

/* Horizontal Triple */
sequential_triple(Board, [X1-Y1, X2-Y2, X3-Y3]):-
    all_valid_white_cells(Board, [X1-Y1, X2-Y2, X3-Y3]),
    Y1 =:= Y2 - 1,
    Y1 =:= Y3 - 2,
    X1 =:= X2,
    X2 =:= X3.

/* Diagonal type "\" Triple */
sequential_triple(Board, [X1-Y1, X2-Y2, X3-Y3]):-
    all_valid_white_cells(Board, [X1-Y1, X2-Y2, X3-Y3]),
    X1 =:= X2 + 1,
    X1 =:= X3 + 2,
    Y1 =:= Y2 + 1,
    Y1 =:= Y3 + 2.

/* Diagonal type "/" Triple */
sequential_triple(Board, [X1-Y1, X2-Y2, X3-Y3]):-
    all_valid_white_cells(Board, [X1-Y1, X2-Y2, X3-Y3]),
    X1 =:= X2 + 1,
    X1 =:= X3 + 2,
    Y1 =:= Y2 - 1,
    Y1 =:= Y3 - 2.


/**
 * Checks if pair X-Y represents a cell on the board and if that cell is white (non-black).
 * 
 * Board -> the puzzle board
 * ListOfPairs -> List of elements in the form X-Y.
**/
% all_valid_white_cells(+Board, +ListOfPairs)
all_valid_white_cells(_, []).
all_valid_white_cells(Board, [X-Y | Tail]):-
    nth1(X, Board, BoardLine),
    nth1(Y, BoardLine, BoardElement),
    check_if_non_black(BoardElement),
    all_valid_white_cells(Board, Tail).


/**
 * Checks if the Element is representative of a white cell.
 * Meaning element is either not instantiated or different that 0 (black cell).
**/
% check_if_non_black(+Element)
check_if_non_black(Element):-
    ground(Element), !, 
    Element =\= 0.
check_if_non_black(_).

/**
 * -----------------------------------------------------------------------------
 * ---------------------   Constraint Appling Predicates   ---------------------
 * -----------------------------------------------------------------------------
**/

/**
 * This predicate makes it impossible for any white cell to be labeled a black cell.
 *
 * BoardList -> the puzzle board as a single continuous list
 *
**/
% apply_non_zero_constraint(+BoardList)
apply_non_zero_constraint([]).
apply_non_zero_constraint([H | Tail]):-
    ground(H), !,
    apply_non_zero_constraint(Tail).
apply_non_zero_constraint([H | Tail]):-
    H #\= 0,
    apply_non_zero_constraint(Tail).

/**
 * Applies the following constraint:
 * "When 3 adjacent white squares are in a line horizontally, vertically,
 *       or diagonally, they should contain exactly 2 of one of the symbols."
 *
 * Board -> the puzzle board
 * ListOfSequentialTriples -> A list containing all groups of 3 adjacent white squares that are in a line
 *                              horizontally, vertically, or diagonally.
**/
% apply_triple_constraint(+Board, +ListOfSequentialTriples)
apply_triple_constraint(_, []).
apply_triple_constraint(Board, [ [Y1-X1, Y2-X2, Y3-X3] |Tail]):-
    nth1(Y1, Board, BoardLine1),
    nth1(X1, BoardLine1, BoardElement1),

    nth1(Y2, Board, BoardLine2),
    nth1(X2, BoardLine2, BoardElement2),

    nth1(Y3, Board, BoardLine3),
    nth1(X3, BoardLine3, BoardElement3),

    nvalue(2, [BoardElement1, BoardElement2, BoardElement3]),

    apply_triple_constraint(Board,Tail).

/**
 * --------------------------------------------------------------------------------
 * ---------------------------   Auxiliary Predicates   ---------------------------
 * --------------------------------------------------------------------------------
**/

/**
* Flattens a list of lists into a list.
*/
% flatten(+ListOfLists, -List)
flatten([], []).
flatten([H| Tail], List):-
    append(H, AuxList, List),
    flatten(Tail, AuxList).
