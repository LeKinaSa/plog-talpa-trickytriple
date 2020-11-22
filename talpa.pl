:-include('intermediate_delivery.pl').
:-include('menu.pl').

% play :- menu(0).
init(D, D-[['O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O'],
              ['O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O'],
              ['O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O'],
              ['O','X','O','X','O','X','O','X'],
              ['X','O','X','O','X','O','X','O']]-1).

play :- init(8, GameState1),
        move(GameState1, 3-3-x, GameState2),
        move(GameState2, 8-5-l, GameState3),
        display_game(GameState3, + 1).