:-include('display.pl').
:-include('board.pl').
:-include('intermediate_delivery.pl').

talpa_game(N) :- talpa_demo(N).
play :- menu(0).
