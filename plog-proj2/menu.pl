:- ensure_loaded('puzzle.pl').
:- ensure_loaded('display.pl').
:- ensure_loaded('puzzle_library.pl').
:- ensure_loaded('puzzle_solutions.pl').

/**
 * --------------------------------------------------------------------------------
 * -----------------------------------   Menu   -----------------------------------
 * --------------------------------------------------------------------------------
**/

/*
 * Menu Selector
**/
% menu(+Menu)
menu(Menu) :-
    Menu > 0,
    display_menu(Menu, MaxOptions),
    obtain_menu_input(NextMenu, MaxOptions),
    !,
    select_next_menu(Menu, NextMenu).

menu(0) :-
    display_menu(0, MaxOptions),
    obtain_menu_input(NextMenu, MaxOptions),
    !,
    NextMenu > 0,
    menu(NextMenu).

/*
 * Helps decide which menu will be shown next
**/
% select_next_menu(+CurrentMenu, +NextMenu)
select_next_menu(CurrentMenu, NextMenu) :-
    CurrentMenu > 0,
    NextMenu > 0,
    start(CurrentMenu-NextMenu, []).

select_next_menu(_, 0) :-
    menu(0).

/**
 * Start the Process of Finding the Solution
**/
% start(+Puzzle, +LabellingOptions)
start(Difficulty-Id, LabellingOptions) :-
    new_line(1),

    Dimensions is Difficulty + 3,
    puzzle(Difficulty, Id, StartingPuzzle),
    write(' Selected Puzzle: \n'),
    display_board(StartingPuzzle, Dimensions),

    statistics(runtime, [Start | _]),
    solve_puzzle(Difficulty, Id, LabellingOptions, CalculatedSolution),
    statistics(runtime, [Stop | _]),

    print_separator,
    write('\n Obtained Solution: \n'),
    display_board(CalculatedSolution, Dimensions),

    Runtime is Stop - Start,
    print_separator,
    print_time(Runtime),

    write('\n Solution on Library: \n'),
    puzzle_solution(Difficulty, Id, LibrarySolution),
    display_board(LibrarySolution, Dimensions).

/**
 * --------------------------------------------------------------------------------
 * -----------------------------------   Input   ----------------------------------
 * --------------------------------------------------------------------------------
**/

/**
 * Skips the rest of the line
**/
% skip_rest_of_line(+Code)
skip_rest_of_line(Code) :-
    Code \= 10, % \n
    skip_line.
skip_rest_of_line(10).

/**
 * Obtain an empty input
**/
% obtain_empty_input
obtain_empty_input :-
    get_code(Code),
    skip_rest_of_line(Code).

/**
 * Obtain the Input
 * From 0 to Max (inclusive)
**/
% obtain_menu_input(-Input, +Max)
obtain_menu_input(Input, Max) :-
    Max > 0,
    get_code(Code),
    skip_rest_of_line(Code),
    Code >= (48 + 0),
    Code =< (48 + Max),
    Input is Code - 48.
obtain_menu_input(Input, Max) :-
    Max > 0,
    obtain_menu_input(Input, Max).
