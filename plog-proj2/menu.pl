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
    select_labeling_options(Options),
    decision(CurrentMenu-NextMenu, Options).

select_next_menu(_, 0) :-
    menu(0).

/**
 * Allows the User to Input the Labeling Options as a Number
**/
% select_labeling_options(-Options)
select_labeling_options(O1-O2-O3) :-
    clr,
    display_header,
    
    display_labeling_option_1,
    obtain_menu_input(O1, 5),

    display_labeling_option_2,
    obtain_menu_input(O2, 2),

    display_labeling_option_3,
    obtain_menu_input(O3, 3).

/**
 * Decides if we will stay on Menu or Start the Solver
**/
% decision(+Puzzle, +Options)
decision(_, Options) :-
    options_contain_zero(Options),
    menu(0).
decision(Puzzle, Options) :-
    optain_labeling_options(Options, LabelingOptions),
    start(Puzzle, LabelingOptions).

/**
 * Checks if the options contain zeros
**/
% options_contain_zero(+Options)
options_contain_zero(0-_-_).
options_contain_zero(_-0-_).
options_contain_zero(_-_-0).

/**
 * Obtain the Labeling Options for our Solver
**/
% optain_labeling_options(+Options, -LabelingOptions)
optain_labeling_options(O1-O2-O3, Labeling) :-
    obtain_labeling_option_1(O1, L1),
    obtain_labeling_option_2(O2, L2),
    obtain_labeling_option_3(O3, L3),
    append([L1], [L2], AuxList),
    append(AuxList, [L3], Labeling).

/**
 * Obtain the First Labeling Option for our Solver
**/
% optain_labeling_option_1(+Option, -LabelingOption)
obtain_labeling_option_1(1, leftmost).
obtain_labeling_option_1(2, ff).
obtain_labeling_option_1(3, ffc).
obtain_labeling_option_1(4, min).
obtain_labeling_option_1(5, max).

/**
 * Obtain the Second Labeling Option for our Solver
**/
% optain_labeling_option_2(+Option, -LabelingOption)
obtain_labeling_option_2(1, up).
obtain_labeling_option_2(2, down).

/**
 * Obtain the Third Labeling Option for our Solver
**/
% optain_labeling_option_3(+Option, -LabelingOption)
obtain_labeling_option_3(1, step).
obtain_labeling_option_3(2, enum).
obtain_labeling_option_3(3, bisect).

/**
 * Start the Process of Finding the Solution
**/
% start(+Puzzle, +LabelingOptions)
start(Difficulty-Id, LabelingOptions) :-
    clr,
    display_header,

    Dimensions is Difficulty + 3,
    puzzle(Difficulty, Id, StartingPuzzle),
    write(' Selected Puzzle: \n'),
    display_grid(StartingPuzzle, Dimensions),

    statistics(runtime, [Start | _]),
    solver(Difficulty, Id, LabelingOptions, CalculatedSolution),
    statistics(runtime, [Stop | _]),

    print_separator,
    write('\n Obtained Solution: \n'),
    display_grid(CalculatedSolution, Dimensions),

    write('\n Solution on Library: \n'),
    puzzle_solution(Difficulty, Id, LibrarySolution),
    display_grid(LibrarySolution, Dimensions),

    Runtime is Stop - Start,
    print_separator,
    print_time(Runtime).

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
obtain_menu_input(_, 0) :-
    obtain_empty_input.
