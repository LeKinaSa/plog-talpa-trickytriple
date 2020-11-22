:-include('intermediate_delivery.pl').
:-include('menu.pl').

% play :- menu(0).
play :- initial(Dimensions-Board-Player),
        new_line(3),
        write(Dimensions),
        space(5),
        write(Player),
        new_line(3),
        display_board(Board, Dimensions),
        new_line(3).
