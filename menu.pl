:- include('display.pl').

% talpa(BoardDifficulty, GameMode)
talpa(Dimensions, RedBot-BlueBot) :-
    clr,
    new_line(1),
    write(Dimensions),
    new_line(2),
    space(4),
    write(RedBot),
    space(4),
    write(BlueBot),
    new_line(1).

/*
 * Menu Selector
 */
% menu(+Menu)
menu(Menu) :-
    Menu > 0,
    display_menu(Menu),
    obtain_menu_input(NextMenu, 3),
    select_next_menu(Menu, NextMenu).

menu(0) :-
    display_menu(0),
    obtain_menu_input(NextMenu, 4),
    menu(NextMenu).

/*
 * Helper Function
 * Helps decide which menu will be shown next
 */
% select_next_menu(+CurrentMenu, +NextMenu)
select_next_menu(CurrentMenu, NextMenu) :-
    NextMenu > 0,
    start_game(CurrentMenu, NextMenu).

select_next_menu(Menu, 0) :-
    menu(0).

/**
 * Obtains All the Information Needed to Start the Game
 * Then Starts It
 * 
 * Gamemode:
 *      1 -  Human   VS  Human
 *      2 -  Human   VS Computer
 *      3 - Computer VS  Human
 *      4 - Computer VS Computer
 * 
 * BoardDifficulty:
 *      1 -  6 x 6  board
 *      2 -  8 x 8  board
 *      3 - 10 x 10 board
 * 
 * Bot Difficulty:
 *      0 - Player
 *      1 - Random
 *      2 - Greedy
 */
% start_game(+Gamemode, +BoardDifficulty)
start_game(Gamemode, BoardDifficulty) :-
    Dimensions is (BoardDifficulty + 2) * 2,
    obtain_bot_difficulty(Gamemode, RedBot-BlueBot),
    talpa(Dimensions, RedBot-BlueBot).

/**
 * Obtain Bot Difficulty (According to Gamemode)
 * BotDifficulty = RedBotDifficulty-BlueBotDifficulty
 * Difficulty:
 *      0 - Player
 *      1 - Random
 *      2 - Greedy
 * Gamemodes:
 *      1 - RedBot = 0, BlueBot = 0
 *      2 - RedBot = 0, BlueBot = ?
 *      2 - RedBot = ?, BlueBot = 0
 *      2 - RedBot = ?, BlueBot = ?
 */
% obtain_bot_difficulty(+Gamemode, -BotDifficulty)
obtain_bot_difficulty(1, 0-0).

obtain_bot_difficulty(2, 0-BlueBot) :-
    print_bot_difficulty_menu(- 1),
    obtain_menu_input(BlueBot, 2).

obtain_bot_difficulty(3, RedBot-0) :-
    print_bot_difficulty_menu(+ 1),
    obtain_menu_input(RedBot, 2).

obtain_bot_difficulty(4, RedBot-BlueBot) :-
    print_bot_difficulty_menu(+ 1),
    obtain_menu_input(RedBot, 2),
    print_bot_difficulty_menu(- 1),
    obtain_menu_input(BlueBot, 2).

/**
 * Obtain the Input
 * From 0 to Max (inclusive)
 */
% obtain_menu_input(-Input, +Max)
obtain_menu_input(Input, Max) :-
    get_code(Input),
    skip_line,
    Input >= (48 + 0),
    Input =< (48 + Max).
