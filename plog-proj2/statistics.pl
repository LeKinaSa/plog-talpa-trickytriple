:- ensure_loaded('puzzle_library.pl').
:- ensure_loaded('display.pl').
:- ensure_loaded('puzzle.pl').

/**
 * --------------------------------------------------------------------------------
 * --------------------------------   Statistics   --------------------------------
 * --------------------------------------------------------------------------------
**/

/**
 * Provide All Statistics for All Puzzles
**/
% statistics
puzzle_statistics :-
    findall(Difficulty-Id, puzzle(Difficulty, Id, _), Set),
    display_header,
    all_stats(Set).

/**
 * Provide Statistics for the Puzzles
**/
% all_stats(+Puzzles)
all_stats([Puzzle | Puzzles]) :-
    stats(Puzzle),
    all_stats(Puzzles).
all_stats([]).

/**
 * Provide Statistics for one Puzzle
**/
% stats(+Puzzle)
stats(Puzzle) :-
    % print_separator,
    print_puzzle_info(Puzzle),
    start_solver(Puzzle, [], Runtime),
    print_time(Runtime).

/**
 * Similar to start/2 but without the prints
**/
% start_solver(+Puzzle, +LabelingOptions, -Runtime)
start_solver(Puzzle, LabellingOptions, Runtime) :-
    statistics(runtime, [Start | _]),
    solver(Puzzle, LabellingOptions),
    statistics(runtime, [Stop | _]),
    Runtime is Stop - Start.

/**
 * Similar to puzzle_solve/2 but without the prints
**/
% solver(+Puzzle, +LabelingOptions)
solver(Difficulty-Id, LabelingOptions):-
    puzzle(Difficulty, Id, Board),
    flatten(Board, BoardList),

    domain(BoardList, 0, 3),
    apply_non_zero_constraint(BoardList),
    findall(SequentialTriple, sequential_triple(Board, SequentialTriple), ListOfSequentialTriples),
    apply_triple_constraint(Board, ListOfSequentialTriples),

    labeling(LabelingOptions, BoardList).
