:- ensure_loaded('puzzle.pl').
:- ensure_loaded('display.pl').

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
    display_menu(Menu),
    obtain_menu_input(NextMenu, 3),
    !,
    select_next_menu(Menu, NextMenu).

menu(0) :-
    display_menu(0),
    obtain_menu_input(NextMenu, 4),
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
    start(CurrentMenu, NextMenu).

select_next_menu(_, 0) :-
    menu(0).

/**
 * Start the Process of Finding the Solution
**/
% start(+Difficulty, +Id)
start(Difficulty, Id) :-
    solve_puzzle(Difficulty, Id, []).

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
