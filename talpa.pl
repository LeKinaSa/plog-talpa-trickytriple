% :- ensure_loaded('intermediate_delivery.pl').
:- ensure_loaded('menu.pl').

% play :- menu(0).

init(6, 6-[   ['O','X','O','X','O','X'],
              ['X','O','X','O','X','O'],
              ['O','X','O','X','O','X'],
              ['X','O','X','O','X','O'],
              ['O','X','O','X','O','X'],
              ['X','O','X','O','X','O']]-1).

init(8, 8-[   ['O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O'],
              ['O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O'],
              ['O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O'],
              ['O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O']]-1).

init(10, 10-[ ['O','X','O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O','X','O'],
              ['O','X','O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O','X','O'],
              ['O','X','O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O','X','O'],
              ['O','X','O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O','X','O'],
              ['O','X','O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O','X','O']]-1).

play :- init(6, GameState),
        game(GameState, 0-0).


/*play :- init(8, GameState),
        game2(GameState, 0-0).

play :- init(8, GameState),
        valid_moves(GameState, _, Moves),
        write(Moves).
game2(GameState, Players) :-
    display_game(GameState, _),
    write('1\n'),
    choose_player_level(GameState, Players, Level),
    write('2\n'),
    choose_move(GameState, _, Level, Move),
    write('3\n'),
    move(GameState, Move, NewGameState),
    write('4\n'),
    game2(NewGameState, Players).
*/
