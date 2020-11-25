/**
* Calculates de Value of Board for the player Player. 
*
* Game State = Dimensions-Board-PlayerOnMove
* Player: The Board will be evaluated acording to this player perspective.  
* Value: An integer beteween 0 and 5 in which 0 is equal to no progress made in forming the path beteween the sides of
*       Player (only on StartingBoard) and 5 is equal to both sides being conected for Player.
*
* Ps: GameState is a complex member with Dimensions-Board-PlayerOnMove. This is PlayerOnMove is usually just called Player
* because on most predicates PlayerOnMove is the one that matters. But value doesn't care about which player is on the move
* it only evaluates de Board for any given player.
*/
% value(+GameState, +Player, -Value)
value(Dimensions-Board-_, Player, Value):-
    calculate_board_value(Dimensions-Board-Player, 1, Dimensions, [], 0, Value).

/*
* The main predicate of value/3. This Predicate goes through the board looking for white cell clusters. 
* Once it has found one it hasn't processed before, it calulates the value of that cluster.
* Once it has reached the end of the board it returns the Maximum Cluster Value it found as the Value of the Board.
*
* Game State = Dimensions-Board-Player
* Column goes from      1     to Dimensions
* Line  goes from Dimensions to      1
* ListOfCheckedEmptySpaces: is a list of cells (Column-Line) of already processed empty spaces.
* MaxValue: current max cluster value
* Final Value: value to be returned
*
*
* Ps: In here the Player in GameState is the player for which the Board is being evaluated not necessarlly
* the player on move.
*/

% calculate_board_value(+GameState, +Column, +Line, ListOfCheckedEmptySpaces, MaxValue, -FinalValue)
/*end of board*/
calculate_board_value(_-_-_, -1, -1, _, Value, Value).
/*not an empty space*/
calculate_board_value(Dimensions-Board-Player, Column, Line, ListOfCheckedEmptySpaces, MaxValue, FinalValue):-
    board_cell(Column-Line, Dimensions-Board, Element),
    Element \= ' ',
    increase_column_and_line(Dimensions, Column, Line, NewColumn, NewLine),
    calculate_board_value(Dimensions-Board-Player, NewColumn, NewLine, ListOfCheckedEmptySpaces, MaxValue, FinalValue).
/*already processed empty space*/
calculate_board_value(Dimensions-Board-Player, Column, Line, ListOfCheckedEmptySpaces, MaxValue, FinalValue):-
    board_cell(Column-Line, Dimensions-Board, ' '),
    member(Column-Line, ListOfCheckedEmptySpaces),
    increase_column_and_line(Dimensions, Column, Line, NewColumn, NewLine),
    calculate_board_value(Dimensions-Board-Player, NewColumn, NewLine, ListOfCheckedEmptySpaces, MaxValue, FinalValue).
/*new cluster of empty spaces found*/
calculate_board_value(Dimensions-Board-Player, Column, Line, ListOfCheckedEmptySpaces, MaxValue, FinalValue):-
    board_cell(Column-Line, Dimensions-Board, ' '),
    \+member(Column-Line, ListOfCheckedEmptySpaces),
    explore_empty_cell_cluster(Dimensions-Board-Player, [Column-Line-1], 0, [], PossibleMaxValue, AuxListOfCheckedEmptySpaces),
    NewMaxValue is max(PossibleMaxValue, MaxValue),
    append(AuxListOfCheckedEmptySpaces, ListOfCheckedEmptySpaces, NewListOfCheckedEmptySpaces),
    increase_column_and_line(Dimensions, Column, Line, NewColumn, NewLine),
    calculate_board_value(Dimensions-Board-Player, NewColumn, NewLine, NewListOfCheckedEmptySpaces, NewMaxValue, FinalValue).


/**
* This predicate explores an empty cell cluster.
* It finds all the adjacent empty cells to the starting one and keeps exporing each new empty cell to find 
* the ones adjacent to that one.
* For each adjacent cell to the bottom it adds 1 to the cluster value if player is red (1).
* For each adjacent cell to the right it adds 1 to the cluster value if player is blue (- 1).
*
* Game State = Dimensions-Board-Player
* CellsToExplore: is a list of empty cells (Column-Line) not already processed.
* AccValue: Acumulator of cluster value.
* ListOfCheckedEmptySpacesSoFar: is a list of empty cells (Column-Line) already processed, used to avoid loops
* FinalMaxValue: Cluster Value
* FinalListOfCheckedEmptySpaces: list of all empty cells (Column-Line) in the cluster
*
*
* Ps: In here the Player in GameState is the player for which the Board is being evaluated not necessarlly
* the player on move.
*/
% explore_empty_cell_cluster(+GameState, CellsToExplore, AccValue , ListOfCheckedEmptySpacesSoFar, -FinalMaxValue, -FinalListOfCheckedEmptySpaces)
/*no more empty cells to process*/
explore_empty_cell_cluster(_, [], AccValue , ListOfCheckedEmptySpacesSoFar, AccValue , ListOfCheckedEmptySpacesSoFar).
/*already processed empty cell, skip*/
explore_empty_cell_cluster(Dimensions-Board-Player, [Column-Line-_ | Tail], AccValue, ListOfCheckedEmptySpacesSoFar, FinalMaxValue, FinalListOfCheckedEmptySpaces):-
    member(Column-Line, ListOfCheckedEmptySpacesSoFar),
    explore_empty_cell_cluster(Dimensions-Board-Player, Tail, AccValue, ListOfCheckedEmptySpacesSoFar, FinalMaxValue, FinalListOfCheckedEmptySpaces).
/*get all adjacent cells to Head cell, and if they added any value */
explore_empty_cell_cluster(Dimensions-Board-Player, [Column-Line-Inc | Tail], AccValue, ListOfCheckedEmptySpacesSoFar, FinalMaxValue, FinalListOfCheckedEmptySpaces):-
    \+member(Column-Line, ListOfCheckedEmptySpacesSoFar),
    NewAccValue is Inc + AccValue,
    findall(X-Y-V, adjacent_empty_cell(Dimensions-Board-Player, Column-Line, X-Y, V), MoreEmptyCells),
    append(Tail, MoreEmptyCells, CellsToExplore),
    explore_empty_cell_cluster(Dimensions-Board-Player, CellsToExplore, NewAccValue, [Column-Line | ListOfCheckedEmptySpacesSoFar], FinalMaxValue, FinalListOfCheckedEmptySpaces).

/*
* Auxiliar predicate. Used to calculate the next cell on the board after receiving the current Column and Line.
* If Board as ended it returns -1, -1.
*
* Dimensions = Board dimensions
* Line  goes from Dimensions to      1
* Column goes from      1     to Dimensions
* NewLine  goes from Dimensions to      1       or -1
* NewColumn goes from      1     to Dimensions  or -1
*
* cell NewColumn-NewLine is next to cell Column-Line on the board
*/
% increase_column_and_line(+Dimensions, +Column, +Line, -NewColumn, -NewLine)
increase_column_and_line(Dimensions, Dimensions, 1, -1, -1).
increase_column_and_line(Dimensions, Column, Line, 1, NewLine):-
    Dimensions < Column + 1,
    0 < Line - 1,
    NewLine is Line - 1.   
increase_column_and_line(Dimensions, Column, Line, NewColumn, Line):-
    Dimensions >= Column + 1,
    NewColumn is Column + 1.


/**
* DO NOT CHANGE THE ORDER OF THESE NEXT PREDICATES
* THE ORDER THEY ARE IN IS CRUCIAL FOR THE CORRECT WORKING OF PREDICATE value/3
*
* This predicate was designed to be called on a findall. By doing this we can get all the adjacent empty cells to an initial
* cell.
* This also gives an added value that depends on the player: if value is being called for the red (1) player then
* every adjacent empty cell on the bottom adds value to the overall cluster; if value is being called for the blue (- 1)
* player then its the right adjacent cells that give value to the cluster.
* 
* Game State = Dimensions-Board-Player
* InitialCell : complex member Column-Line that gives the location of the cell being processed
* AdjacentCell : complex member Column-Line that gives the location of the adjacent cell
* AddedValue : 0 or 1 depeding if the adjacent cell adds value to Player
*
* Ps: the order is important in order to avoid double counting value. 
*/

% adjacent_empty_cell(+GameState, +InitialCell, -AdjacentCell, -AddedValue)
adjacent_empty_cell(Dimensions-Board-1, X-Y, X-UpY, 1):-
    X >= 1, X =< Dimensions,
    Y >= 1, Y =< Dimensions,
    UpY is Y - 1,
    UpY >= 1,
    board_cell(X-UpY, Dimensions-Board, ' ').

adjacent_empty_cell(Dimensions-Board-Player, X-Y, RightX-Y, 1):-
    Player \= 1,
    X >= 1, X =< Dimensions,
    Y >= 1, Y =< Dimensions,
    RightX is X + 1,
    RightX =< Dimensions,
    board_cell(RightX-Y, Dimensions-Board, ' ').

adjacent_empty_cell(Dimensions-Board-Player, X-Y, X-UpY, 0):-
    Player \= 1,
    X >= 1, X =< Dimensions,
    Y >= 1, Y =< Dimensions,
    UpY is Y - 1,
    UpY >= 1,
    board_cell(X-UpY, Dimensions-Board, ' ').

adjacent_empty_cell(Dimensions-Board-1, X-Y, RightX-Y, 0):-
    X >= 1, X =< Dimensions,
    Y >= 1, Y =< Dimensions,
    RightX is X + 1,
    RightX =< Dimensions,
    board_cell(RightX-Y, Dimensions-Board, ' ').

adjacent_empty_cell(Dimensions-Board-_, X-Y, X-DownY, 0):-
    X >= 1, X =< Dimensions,
    Y >= 1, Y =< Dimensions,
    DownY is Y + 1,
    DownY =< Dimensions,
    board_cell(X-DownY, Dimensions-Board, ' ').

adjacent_empty_cell(Dimensions-Board-_, X-Y, LeftX-Y, 0):-
    X >= 1, X =< Dimensions,
    Y >= 1, Y =< Dimensions,
    LeftX is X - 1,
    LeftX >= 1,
    board_cell(LeftX-Y, Dimensions-Board, ' ').



/*

TODO::TESTING PREDICATES DELETE BEFORE DELIVERY

*/

boards(1,[ ['O','X','O','X','O','X',' ','X'],
           ['X','O','X','O','X','O',' ','O'],
           ['O','X','O','X','O','X','O','X'],
           ['X','O',' ',' ',' ','O','X','O'],
           ['O','X',' ','X',' ','X','O','X'],
           ['X','O','X','O',' ','O','X','O'],
           ['O','X','O','X','O','X','O','X'],
           ['X','O','X','O','X','O','X','O']
]).

test_value(Player):-
    boards(1, Board),
    value(8-Board-1, Player, Value),
    /*explore_empty_cell_cluster(8-Board-1, [3-4-0], 0, [], PossibleMaxValue, AuxListOfCheckedEmptySpaces),

    
    write(PossibleMaxValue),
    write(AuxListOfCheckedEmptySpaces).*/
    write(Value).


test_increase_colum:-
    boards(1, Board),
    print_board(8-Board-1, 1, 8).


print_board(Dimensions-Board-Player, Column, Line):-
    increase_column_and_line(Dimensions, Column, Line, X, Y),
    print_board(Dimensions-Board-Player, X, Y).
