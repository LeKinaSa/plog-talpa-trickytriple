/*
 * --------------------------------------------------------------------------------
 * --------------------   Helper Functions To Draw the Board   --------------------
 * --------------------------------------------------------------------------------
**/

/*
 * Clear the Board
**/
% clr
clr :- write('\33\[2J').

/*
 * Prints N Empty Lines to the Screen
**/
% new_line(+N)
new_line(N) :-
    N > 1,
    nl,
    Next is N - 1,
    new_line(Next).
new_line(1) :- nl.

/*
 * Prints N Spaces to the Screen
**/
% space(+N)
space(N) :-
    N > 1,
    write(' '),
    Next is N - 1,
    space(Next).
space(1) :- write(' ').

/**
 * Prints a Vertical Division
**/
% print_vertical_division
print_vertical_division :-
    space(1),
    write('|'),
    space(1).

/**
 * Prints a Number of Horizontal Divisions
**/
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
 * Display the Board
**/
% display_board(+Board, +Dimensions)
display_board(Board, Dimensions) :-
    space(3),
    print_horizontal_division(Dimensions),
    new_line(1),
    print_board(Board, Dimensions).

/**
 * Print All the Lines on the Board
**/
% print_board(+Board, +Dimensions)
print_board([Line | Board], Dimensions) :-
    print_board_line(Line),
    new_line(1),
    space(3),
    print_horizontal_division(Dimensions),
    new_line(1),
    print_board(Board, Dimensions).
print_board([], _).

/**
 * Print a Line
**/
% print_board_line(+Line)
print_board_line(Line) :-
    space(2),
    print_vertical_division,
    print_board_line_elements(Line).

/**
 * Print All the Pieces on the Line
**/
% print_board_line_elements(+Line)
print_board_line_elements([Element | Line]) :-
    ground(Element), !,
    write(Element),
    print_vertical_division,
    print_board_line_elements(Line).
print_board_line_elements([_ | Line]) :-
    write(' '),
    print_vertical_division,
    print_board_line_elements(Line).
print_board_line_elements([]).

/*
 * --------------------------------------------------------------------------------
 * ------------------------------   Draw the Header   -----------------------------
 * --------------------------------------------------------------------------------
**/

/**
 * Display a Header for our Tricky Triple Puzzle
**/
% display_header
display_header:-
    write('*********************************\n'),
    write('****                         ****\n'),
    write('****      TRICKY TRIPLE      ****\n'),
    write('****                         ****\n'),
    write('*********************************\n').

/*
 * --------------------------------------------------------------------------------
 * ------------------------------   Draw the Menus   ------------------------------
 * --------------------------------------------------------------------------------
**/

/**
 * Display a Menu
**/
% display_menu(+Menu, -MaxOptions)
display_menu(Menu, MaxOptions) :-
    clr,
    display_header,
    print_menu(Menu, MaxOptions).

/**
 * Print the Selected Menu
 * 0 - Main Menu
 * 1 - Difficulty 1
 * 2 - Difficulty 2
 * 3 - Difficulty 3
 * 4 - Difficulty 4
**/
% print_menu(+SelectedMenu, -MaxOptions)
print_menu(0, 4) :-
    write('*********************************\n'),
    write('*           MAIN MENU           *\n'),
    write('*********************************\n'),
    write('*   [1] Difficulty 1            *\n'),
    write('*   [2] Difficulty 2            *\n'),
    write('*   [3] Difficulty 3            *\n'),
    write('*   [4] Difficulty 4            *\n'),
    write('*********************************\n').

print_menu(1, 7) :-
    print_difficulty_menu(1, 7).

print_menu(2, 7) :-
    print_difficulty_menu(2, 7).

print_menu(3, 5) :-
    print_difficulty_menu(3, 5).

print_menu(4, 4) :-
    print_difficulty_menu(4, 5).

/**
 * Print a Menu Choosing the Difficulty
**/
% print_difficulty_menu(+Difficulty, +NumberOfPuzzles)
print_difficulty_menu(Difficulty, NumberOfPuzzles) :-
    write('*          Difficulty '),
    write(Difficulty),
    write('         *\n'),
    write('*********************************\n'),
    write('*   [1-'),
    write(NumberOfPuzzles),
    write('] Id                    *\n'),
    write('*   [0] Back                    *\n'),
    write('*********************************\n').
