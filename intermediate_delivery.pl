/*
 --------------------------------------------------------------------------------
 --------------------   Static Representations of the Board  --------------------
 --------------------------------------------------------------------------------
**/

/*
    1 - Inicial (Generating the Board)
    2 - Intermediate
    3 - Red has only two possible moves, a losing one and a winning one
    4 - Final - Red has won the game
    5 - Final - Blue has won the game (Red has opened a path for both players. Meaning that he has to open a path for Blue, which means Red has lost the game.)
*/

/* Boards */
/*
Static Representation of the Initial Board
boards(1,[ ['O','X','O','X','O','X','O','X'],
           ['X','O','X','O','X','O','X','O'],
           ['O','X','O','X','O','X','O','X'],
           ['X','O','X','O','X','O','X','O'],
           ['O','X','O','X','O','X','O','X'],
           ['X','O','X','O','X','O','X','O'],
           ['O','X','O','X','O','X','O','X'],
           ['X','O','X','O','X','O','X','O']
]).
*/

boards(2,[ ['O','X','O',' ','X','X','O','X'],
           ['X','O',' ','X','X',' ','X','O'],
           [' ','O',' ',' ',' ',' ','O','X'],
           ['X','O',' ','X','X','O','X','O'],
           [' ','O',' ',' ','O','O','O','O'],
           ['O','O','X',' ',' ',' ','X',' '],
           [' ','X','O',' ','X',' ','O','O'],
           ['X','O','X','X',' ','X','X',' ']
        ]).

boards(3,[ ['X',' ','X',' ','X',' ','O',' '],
           [' ','O',' ','X','X',' ','O',' '],
           [' ','O',' ',' ',' ',' ',' ','O'],
           ['O',' ',' ','O',' ',' ',' ',' '],
           [' ','O',' ',' ','X',' ',' ','O'],
           ['O',' ',' ',' ',' ',' ','X',' '],
           [' ','X','O',' ','X',' ','O',' '],
           [' ','O',' ','X',' ','X',' ',' ']
        ]).

boards(4,[ ['X',' ','X',' ','X',' ','O',' '],
           [' ','O',' ','X','X',' ','O',' '],
           [' ','O',' ',' ',' ',' ',' ','O'],
           ['O',' ',' ','O',' ',' ',' ',' '],
           [' ','O',' ',' ','X',' ',' ','O'],
           ['O',' ',' ',' ',' ',' ',' ',' '],
           [' ','X','O',' ','X',' ','X',' '],
           [' ','O',' ','X',' ','X',' ',' ']
        ]).

boards(5,[ ['X',' ','X',' ','X',' ','O',' '],
           [' ','O',' ','X','X',' ','O',' '],
           [' ','O',' ',' ',' ',' ',' ','O'],
           ['O',' ',' ','O',' ',' ',' ',' '],
           [' ','O',' ',' ','X',' ',' ','O'],
           ['O',' ',' ',' ',' ',' ','X',' '],
           [' ',' ','X',' ','X',' ','O',' '],
           [' ','O',' ','X',' ','X',' ',' ']
        ]).

/* Next Player to Move */
player_on_move(1, + 1).
player_on_move(2, - 1).
player_on_move(3, + 1).
player_on_move(4, - 1).  /* Red Win */
player_on_move(5, + 1).  /* Blue Win */

/*
 --------------------------------------------------------------------------------
 -------------------- Demonstration --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Display the Game for a Given Board
 * 
 * 1 - Initial Board
 * 2 - Intermediate Board
 * 3 - Red is forced to make a losing move
 * 4 - Final Board - Red Wins
 * 5 - Final Board - Blue Wins
 */
% talpa(+BoardNumber)
/*
    This predicate references the initial state of the game. Therefore, it uses the predicate initial/1.
 */
talpa(1):-
    initial(Dimensions-InitialBoard),
    player_on_move(1, Player),

    clr,
    new_line(1),
    display_header,
    display_game(Dimensions-InitialBoard, Player),
    new_line(1).
/*
    This predicate references the intermediates and final states of the game.
        These are defined statically, which means that we need to call them.
*/
talpa(BoardNumber):-
    BoardNumber > 1,
    Dimensions is 8,
    boards(BoardNumber, Board),
    player_on_move(BoardNumber, Player),

    clr,
    new_line(1),
    display_header,
    display_game(Dimensions-Board, Player),
    new_line(1).
