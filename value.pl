%value(+GameState, +Player, -Value)

/*
Dimensions-Board-Player

I tried a deph-first search through the board as if it was a graph, 
calculating every possible path throught the board and then getting the one with least pieces
in the way.

It works for size 4 boards so the code is somewhat correct but for anyting bigger than that
it takes forever, or it runs out of memory.

Maybe a diferent aproach or optimise this.

Also I got the player switched at some point in the code so the values are reversed
*/

value(Dimensions-Board-_, 1, TotalValue):-
    value_and_path_calculation(Dimensions-Board, 1, RedValue, _),
    value_and_path_calculation(Dimensions-Board, -1, BlueValue, _),
    TotalValue is RedValue - BlueValue.

value(Dimensions-Board-_, -1, TotalValue):-
    value_and_path_calculation(Dimensions-Board, 1, RedValue, _),
    value_and_path_calculation(Dimensions-Board, -1, BlueValue, _),
    TotalValue is BlueValue - RedValue.



value_and_path_calculation(Dimensions-Board, Player, Value, ClearedPath):-
    generate_list_of_starting_nodes(Dimensions, Player, List_Of_No_inicial),
    get_final_node(Dimensions, Player, No_final),
    setof(Cost-Path, explore_prof(Dimensions-Board, Player, List_Of_No_inicial, No_final, Cost-Path), [Value-ClearedPath | _]).


explore_prof(BoardInfo, Player, List_Of_No_inicial, No_final, Cost-Path):-
    member(No_inicial, List_Of_No_inicial),
    explore_prof_aux(BoardInfo, Player, No_inicial, No_final, 0-[No_inicial] , Cost-Path).

/*red finish*/
explore_prof_aux(_, 1, _-Y, _-Y, Z, Z).
/*blue finish*/
explore_prof_aux(_, -1, X-_, X-_, Z, Z).
explore_prof_aux(Dimensions-Board, Player, No_inicial, No_final, Acc-Path, Cost-FinalPath):-
    graph_conection(Dimensions, No_inicial, No_Intermedio),
    calulate_cell_value(No_Intermedio, Dimensions-Board, Value),
    \+member(No_Intermedio, Path),
    append(Path, [No_Intermedio], NewPath),
    Acc1 is Acc + Value,
    explore_prof_aux(Dimensions-Board, Player, No_Intermedio, No_final, Acc1-NewPath, Cost-FinalPath).





generate_list_of_starting_nodes(Dimensions, Player, List):-
    generate_list_of_starting_nodes_aux(Dimensions, Player, 1, [], List).

generate_list_of_starting_nodes_aux(Dimensions, -1, Dimensions, List, NewList):-
    append(List, [1-Dimensions], NewList).
generate_list_of_starting_nodes_aux(Dimensions, 1, Dimensions, List, NewList):-
    append(List, [Dimensions-1], NewList).

generate_list_of_starting_nodes_aux(Dimensions , -1, Counter, List, FinalList):-
    append(List, [1-Counter], NewList),
    Counter1 is Counter + 1,
    generate_list_of_starting_nodes_aux(Dimensions, -1, Counter1, NewList, FinalList).

generate_list_of_starting_nodes_aux(Dimensions , 1, Counter, List, FinalList):-
    append(List, [Counter-1], NewList),
    Counter1 is Counter + 1,
    generate_list_of_starting_nodes_aux(Dimensions, 1, Counter1, NewList, FinalList). 


get_final_node(Dimensions, 1, _-Dimensions).
get_final_node(Dimensions, -1, Dimensions-_).



calulate_cell_value(Column-Line, Dimensions-Board, 0):-
    board_cell(Column-Line, Dimensions-Board, ' '), !.
calulate_cell_value(_, _, 1).





graph_conection(Dimensions, X-Y, RightX-Y):-
    X >= 1, X =< Dimensions,
    Y >= 1, Y =< Dimensions,
    RightX is X + 1,
    RightX =< Dimensions.

graph_conection(Dimensions, X-Y, LeftX-Y):-
    X >= 1, X =< Dimensions,
    Y >= 1, Y =< Dimensions,
    LeftX is X - 1,
    LeftX >= 1.

graph_conection(Dimensions, X-Y, X-UpY):-
    X >= 1, X =< Dimensions,
    Y >= 1, Y =< Dimensions,
    UpY is Y - 1,
    UpY >= 1.

graph_conection(Dimensions, X-Y, X-DownY):-
    X >= 1, X =< Dimensions,
    Y >= 1, Y =< Dimensions,
    DownY is Y + 1,
    DownY =< Dimensions.