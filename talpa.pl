/*-------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
                    Generate a Initial Board of Dimensions "Dimensions"
---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------*/


/*
---->create_initial_board(+Dimensions, -Board)
Creates a list made of Dimensions*Dimensions cells 
and then populates that list with the correct elements , aka pieces,
making that list a valid representation of the starting board of talpa 
*/
%create_initial_board(+Dimensions, -Board)
create_initial_board(Dimensions, InitialBoard):-
    Dimensions >= 4,
    Dimensions mod 2 =:= 0,
    NumberOfCells is Dimensions*Dimensions,
    length(InitialBoard, NumberOfCells),
    populate_board(InitialBoard).

/*
populate_board(Board)
Auxiliary predicate to create_initial_board/2.
It goes through the list "Board" instanciating the values with correrct symbols
*/
%populate_board(Board)
populate_board([]).
populate_board([X, Y | Tail]):-
    X = 'O',
    Y = 'X',
    populate_board(Tail).


/*-------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
            Static Representations of Initial, Intermidiate and Final Game States
1-inicial(Boards is Generated)    2-intermediate   3-Red is forced to make a losing move   4-final
---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------*/

/*
Static Representation of the Initial Board
boards(1, ['O','X','O','X','O','X','O','X',
           'X','O','X','O','X','O','X','O',
           'O','X','O','X','O','X','O','X',
           'X','O','X','O','X','O','X','O',
           'O','X','O','X','O','X','O','X',
           'X','O','X','O','X','O','X','O',
           'O','X','O','X','O','X','O','X',
           'X','O','X','O','X','O','X','O'
]).
*/

boards(1, InitialBoard):-
    create_initial_board(8, InitialBoard).
 
boards(2,[ 'O','X','O',' ','X','X','O','X',
           'X','O',' ','X','X',' ','X','O',
           ' ','O',' ',' ',' ',' ','O','X',
           'X','O',' ','X','X','O','X','O',
           ' ','O',' ',' ','O','O','O','O',
           'O','O','X',' ',' ',' ','X',' ',
           ' ','X','O',' ','X',' ','O','O',
           'X','O','X','X',' ','X','X',' '
]).

boards(3,[ 'X',' ','X',' ','X',' ','O',' ',
           ' ','O',' ','X','X',' ','O',' ',
           ' ','O',' ',' ',' ',' ',' ','O',
           'O',' ',' ','O',' ',' ',' ',' ',
           ' ','O',' ',' ','X',' ',' ','O',
           'O',' ',' ',' ',' ',' ','X',' ',
           ' ','X','O',' ','X',' ','O',' ',
           ' ','O',' ','X',' ','X',' ',' '
]).

/*
On board nº3, Red is forced to capture one of two pieces that open the path of empty spaces 
for both players. Meaning that he was open a path for Blue, wich means Red has lost the game.

Ruling Reference: "A  player loses  the  game  immediately  if  he makes a move that opens 
the path of empty spaces between  the  opponent's  edges  even  if  this  move opens  the  
path  between  his  own  edges  the  same time."
*/

boards(4,[ 'X',' ','X',' ','X',' ','O',' ',
           ' ','O',' ','X','X',' ','O',' ',
           ' ','O',' ',' ',' ',' ',' ','O',
           'O',' ',' ','O',' ',' ',' ',' ',
           ' ','O',' ',' ','X',' ',' ','O',
           'O',' ',' ',' ',' ',' ',' ',' ',
           ' ','X','O',' ','X',' ','X',' ',
           ' ','O',' ','X',' ','X',' ',' '
]).

captured_pieces(1, [0, 0]).
captured_pieces(2, [11, 10]).
captured_pieces(3, [20, 20]).
captured_pieces(4, [21, 20]). /*But blue has won*/

player_on_move(1, red).
player_on_move(2, blue).
player_on_move(3, red).
player_on_move(4, blue). /*But blue has won*/


/*-------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
                            Auxiliar Predicates For Drawing
---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------*/

/*
---->clr
clear the screen
*/
clr :- write('\33\[2J').

/*
---->new_line(+Number)
it print a Number of new lines on the screen.
*/
new_line(1) :- nl.
new_line(N) :-
    N > 1,
    nl,
    Next is N - 1,
    new_line(Next).

/*
---->space(+Number)
it print a Number of spaces on the screen.
*/
space(1) :- write(' ').
space(N) :-
    N > 1,
    write(' '),
    Next is N - 1,
    space(Next).

/*
---->print_vertical_division
prints a vertical division on the screen
*/
print_vertical_division:- write(' | ').

/*
---->print_horizontal_division(+Number)
prints a horizontal division Number times on the screen
*/
print_horizontal_division(1):-
    write('-----').
print_horizontal_division(Number):-
    write('----'),
    Number1 is Number - 1,
    print_horizontal_division(Number1). 

/*
---->print_colum_marking(+NumberColums, +Letter)
print the colum markings starting in Letter
*/
print_colum_marking(0, _).
print_colum_marking(NumberColums, Letter):-
    space(2),
    put_code(Letter),
    space(1),
    NumberColums1 is NumberColums - 1,
    Letter1 is Letter + 1,
    print_colum_marking(NumberColums1, Letter1).

/*
---->print_colum_markings(+NumberColums)
prints the leters that mark each colum starting in A
*/
print_colum_markings(NumberColums):-
    Letter is 65,
    print_colum_marking(NumberColums, Letter).

/*
---->print_line_marking(+NumberLine)
prints the numbers that mark the lines
*/
print_line_marking(NumberLine):- 
    write(NumberLine).


/*-------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
                            Predicates For Drawing
---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------*/

/*
---->display_header
display a sort of header for presentation purposes
*/
display_header :-
    write('*******************************************************\n'),
    write('****                                               ****\n'),
    write('****                     TALPA                     ****\n'),
    write('****                                               ****\n'),
    write('*******************************************************\n').


print_captured_pieces([NumberOfCaputuredPiecesByRed, NumberOfCaputuredPiecesByBlue]):-
    write('Red  Captures : ', NumberOfCaputuredPiecesByRed),
    new_line(1),
    write('Blue Captures : ', NumberOfCaputuredPiecesByBlue),
    new_line(1).

/*
---->print_board_line(+Board, +Colums, -Board1)
print a Line of the Board and returs a Board without the line that was printed (Board1) 
*/
print_board_line(Board, 0, Board).
print_board_line([Cell | Tail], Colums, Board1):-
    Colums1 is Colums - 1,
    write(Cell),
    print_vertical_division,
    print_board_line(Tail, Colums1, Board1). 

/*
---->print_board_lines(+Board, +Lines, +Colums)
prints the boards lines
*/
print_board_lines(_, 0, _).
print_board_lines(Board, Lines, Colums):-
    space(2),
    print_line_marking(Lines),
    print_vertical_division,
    print_board_line(Board, Colums, Board1),
    print_line_marking(Lines),
    new_line(1),
    
    
    space(4),
    print_horizontal_division(Colums),
    new_line(1),

    Lines1 is Lines - 1,
    print_board_lines(Board1, Lines1, Colums).

/*
--->print_board(+Board, +Dimensions)
prints a Dimensions x Dimensions board of talpa
*/
print_board(Board, Dimensions):-
    space(4),
    print_colum_markings(Dimensions),
    new_line(1),
    space(4),
    print_horizontal_division(Dimensions),
    new_line(1),

    print_board_lines(Board, Dimensions, Dimensions),

    space(4),
    print_colum_markings(Dimensions),
    new_line(1).

/*
---->display_game(+GameState, +Player).
draws the game state on the screen
GameState - complex member made of Dimensions , Board and CapturedPieces (Dimensions-Board-CapturedPieces) 
Dimensions - the dimension of the square board
Board - the list that represents the board
CapturedPieces - a list of 2 members that count the number of pieces captured [NumberOfCaputuredPiecesByRed, NumberOfCaputuredPiecesByBlue]
Player - the player on move
*/
display_game(Dimensions-Board-CapturedPieces, red):-
    write('  Red(X) on move:'), new_line(2),
    print_captured_pieces(CapturedPieces),
    print_board(Board, Dimensions).
display_game(Dimensions-Board-CapturedPieces, blue):-
    write('  Blue(O) on move:'), new_line(2),
    print_captured_pieces(CapturedPieces),
    print_board(Board, Dimensions).


/*
---->talpa(+Board)
displays the desired board:
    1-inicial
    2-intermediate
    3-Red is forced to make a losing move
    4-final
*/
talpa(X):-
    boards(X, Board),
    captured_pieces(X, CapturedPieces),
    player_on_move(X, Player),
    Dimensions is 8,

    clr,
    display_header,
    display_game(Dimensions-Board-CapturedPieces, Player).


/*-------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
                            Predicates For Demonstration
---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------*/

initial(Dimensions-InitialBoard-CapturedPieces) :- Dimensions is 8,
                                                   CapturedPieces is [0, 0],
                                                   create_initial_board(Dimensions, InitialBoard).

% play() :- talpa(X).
