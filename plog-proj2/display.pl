/*
 * --------------------------------------------------------------------------------
 * --------------------   Helper Functions To Draw the Board   --------------------
 * --------------------------------------------------------------------------------
**/

/*
 * Clear the Board
 */
% clr
clr :- write('\33\[2J').

/*
 * Prints N Empty Lines to the Screen
 */
% new_line(+N)
new_line(N) :-
    N > 1,
    nl,
    Next is N - 1,
    new_line(Next).
new_line(1) :- nl.

/*
 * Prints N Spaces to the Screen
 */
% space(+N)
space(N) :-
    N > 1,
    write(' '),
    Next is N - 1,
    space(Next).
space(1) :- write(' ').

/**
 * Prints a Vertical Division
 */
% print_vertical_division
print_vertical_division :-
    space(1),
    write('|'),
    space(1).

/**
 * Prints a Number of Horizontal Divisions
 */
% print_horizontal_division(+N)
print_horizontal_division(N) :-
    N > 0,
    write('----'),
    Next is N - 1,
    print_horizontal_division(Next).
print_horizontal_division(0) :- write('-').

/*
 * --------------------------------------------------------------------------------
 * ------------------------------   Draw the Board   ------------------------------
 * --------------------------------------------------------------------------------
**/

/**
 * Print All the Lines on the Board
 */
% print_board(+Board, +Dimensions)
print_board([Line | Board], Dimensions) :-
    print_board_line(Line),
    new_line(1),
    space(4),
    print_horizontal_division(Dimensions),
    new_line(1),
    print_board(Board, Dimensions).
print_board([], _).

/**
 * Print a Line
 */
% print_board_line(+Line)
print_board_line(Line) :-
    space(2),
    print_vertical_division,
    print_board_line_elements(Line).


/**
 * Print All the Pieces on the Line
 */
% print_board_line_elements(+Line)
print_board_line_elements([Element | Line]) :-
    write(Element),
    print_vertical_division,
    print_board_line_elements(Line).
print_board_line_elements([]).

/**
 * Display the Game Board
 */
% display_board(+Board, +Dimensions)
display_board(Board, Dimensions) :-
    space(4),
    print_horizontal_division(Dimensions),
    new_line(1),
    print_board(Board, Dimensions).
