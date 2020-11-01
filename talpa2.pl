/**
 --------------------------------------------------------------------------------
 --------------------        Create the Initial Board        --------------------
 --------------------------------------------------------------------------------
**/

/**
 * Creates a list of Dimensions lists
 *      containing all elements from a line (Dimensions elements).
 * Populates all the lists making this board
 *      a valid representation of the starting board of talpa.
 */
% create_initial_board(+Dimensions, -InitialBoard)
create_initial_board(Dimensions, InitialBoard):-
    Dimensions >= 4,
    Dimensions mod 2 =:= 0,
    length(InitialBoard, Dimensions),
    populate_board(InitialBoard, Dimensions, Dimensions).

/**
 * Populates the board with the lists with the elements from a line
 * Goes through the board, initializing all the lines
 */
% populate_board(-Board, +Lines, +Columns)
populate_board([X, Y | Tail], Lines, Columns) :-
    Lines >= 2,
    populate_even_line(X, Columns),
    populate_odd_line(Y, Columns),
    LinesAux is Lines - 2,
    populate_board(Tail, LinesAux, Columns).

populate_board([], _, _).

/**
 * Populates a even line of our board
 * Goes through the line, instanciating the values with the correct symbols
 */
% populate_even_line(-Line, +Columns)
populate_even_line([X , Y | Line], Columns) :-
    Columns >= 2,
    X = 'O',
    Y = 'X',
    ColumnsAux is Columns - 2,
    populate_even_line(Line, ColumnsAux).

populate_even_line([], 0).

/**
 * Populates a odd line of our board
 * Goes through the line, instanciating the values with the correct symbols
 */
% populate_odd_line(-Line, +Columns)
populate_odd_line([X, Y | Line], Columns) :-
    Columns >= 2,
    X = 'X',
    Y = 'O',
    ColumnsAux is Columns - 2,
    populate_odd_line(Line, ColumnsAux).

populate_odd_line([], 0).

/*
 --------------------------------------------------------------------------------
 --------------------   Helper Functions To Draw the Board   --------------------
 --------------------------------------------------------------------------------
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

/**
 * Print the Column Marking
 */
% print_column_marking(+Columns, +Letter)
print_column_marking(Columns, Letter) :-
    Columns > 0,
    space(2),
    put_code(Letter),
    space(1),
    ColumnsAux is Columns - 1,
    LetterAux is Letter + 1,
    print_column_marking(ColumnsAux, LetterAux).
print_column_marking(0, _).

/**
 * Print all the Columns Markings
 */
% print_column_markings(+Columns)
print_column_markings(Columns) :-
    print_column_marking(Columns, 65).

/**
 * Print Line Marking
 */
% print_line_marking(+Line)
print_line_marking(Line) :- write(Line).

/*
 --------------------------------------------------------------------------------
 --------------------             Draw the Board             --------------------
 --------------------------------------------------------------------------------
**/
/**
 * Display a Header for our Talpa Game Board
 */
% display_header
display_header :-
    write('*******************************************************\n'),
    write('****                                               ****\n'),
    write('****                     TALPA                     ****\n'),
    write('****                                               ****\n'),
    write('*******************************************************\n').

/**
 * Display the Current Player
 */
% display_player(+Player)
display_player(red) :-
    space(4),
    write('Red (X) on move').
display_player(blue) :-
    space(4),
    write('Blue (O) on move').
/**
 * Display the Number of Captured Pieces, for red and blue
 */
% display_captured_pieces([+NumberOfCaputuredPiecesByRed, +NumberOfCaputuredPiecesByBlue])
display_captured_pieces([NumberOfCaputuredPiecesByRed, NumberOfCaputuredPiecesByBlue]) :-
    space(4),
    write('Red as Captured '),
    write(NumberOfCaputuredPiecesByRed),
    write(' pieces.'),
    new_line(1),
    space(4),
    write('Blue as Captured '),
    write(NumberOfCaputuredPiecesByBlue),
    write(' pieces.'),
    new_line(1).

/**
 * Print All the Lines on the Board
 */
% print_board(+Board, +Columns, +LineNumber)
print_board([Line | Board], Columns, LineNumber) :-
    print_board_line(Line, LineNumber),
    new_line(1),
    space(4),
    print_horizontal_division(Columns),
    new_line(1),
    LineNumberAux is LineNumber - 1,
    print_board(Board, Columns, LineNumberAux).
print_board([], _, 0).

/**
 * Print a Line
 */
% print_board_line(+Line, +LineNumber)
print_board_line(Line, LineNumber) :-
    space(2),
    print_line_marking(LineNumber),
    print_vertical_division,
    print_board_line_elements(Line),
    print_line_marking(LineNumber).

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
    print_column_markings(Dimensions),
    new_line(1),

    space(4),
    print_horizontal_division(Dimensions),
    new_line(1),
    
    print_board(Board, Dimensions, Dimensions),

    space(4),
    print_column_markings(Dimensions),
    new_line(1).

/**
 * Display the Game State on Screen
 * Game State      - complex member made of Board, Dimensions and Captured Pieces ( Dimensions-Board-CapturedPieces )
 * Dimensions      - dimension of the square board
 * Board           - list of lists that represents the square board of the game
 * Captured Pieces - list of 2 elements that count the number of pieces captured ( [NumberOfCaputuredPiecesByRed, NumberOfCaputuredPiecesByBlue] )
 * Player          - the next player to move
 */
% display_game(+GameState, +Player)
display_game(Dimensions-Board-CapturedPieces, Player) :-
    display_player(Player),
    new_line(2),
    display_captured_pieces(CapturedPieces),
    new_line(2),
    display_board(Board, Dimensions).

/*
 --------------------------------------------------------------------------------
 --------------------   Static Representations of the Board  --------------------
 --------------------------------------------------------------------------------
**/

/*
    1 - Inicial (Generating the Board)
    2 - Intermediate
    3 - Red is forced to make a losing move
    4 - Final
 */

/*
        TODO
    On board number 3, Red is forced to capture one of two pieces that open the path of empty spaces 
        for both players. Meaning that he has to open a path for Blue, which means Red has lost the game.
*/

/* Boards */
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

/* Captured Pieces */
captured_pieces(1, [0, 0]).
captured_pieces(2, [11, 10]).
captured_pieces(3, [20, 20]).
captured_pieces(4, [21, 20]). /* Blue Win */

/* Next Player to Move */
player_on_move(1, red).
player_on_move(2, blue).
player_on_move(3, red).
player_on_move(4, blue). /* Blue Win */

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
 * 4 - Final Board - Blue Wins
 */
% talpa(+BoardNumber)
/*This rule references the initial state of the game,
    therefor it uses the predicate initial/1 */
talpa(1):-
    initial(Dimensions-InitialBoard-CapturedPieces),
    player_on_move(1, Player),

    clr,
    display_header,
    display_game(Dimensions-InitialBoard-CapturedPieces, Player).
/*This rule references the intermidiates and final states of the game,
    these are defined statically so they must be called.*/
talpa(BoardNumber):-
    Dimensions is 8,
    boards(BoardNumber, Board),
    captured_pieces(BoardNumber, CapturedPieces),
    player_on_move(BoardNumber, Player),

    clr,
    display_header,
    display_game(Dimensions-Board-CapturedPieces, Player).

/**
 * Initial Game State
 * Game State = Dimensions-Board-CapturedPieces
 */
% initial(-GameState)
initial(8-InitialBoard-[0, 0]) :-
    create_initial_board(8, InitialBoard).

/**
 * Next Game State
 */
play :- talpa(X).
% play :- talpa(1).
% play :- talpa(2).
% play :- talpa(3).
% play :- talpa(4).
