:- ensure_loaded('puzzle_library.pl').
:- ensure_loaded('display.pl').
:- ensure_loaded('puzzle.pl').

/**
 * --------------------------------------------------------------------------------
 * --------------------------------   Statistics   --------------------------------
 * --------------------------------------------------------------------------------
**/

/**
 * Testing and Statistics
**/
% test
test :-
    get_options(Options),
    get_statistics(Options).

/**
 * Provide Statistics for All the Labeling Options
**/
get_statistics([Option | Options]) :-
    print_options(Option),
    puzzle_statistics(Option),
    get_statistics(Options).
get_statistics([]).

/**
 * Obtains All the Options for Labeling
**/
% get_options(-Options)
get_options([[leftmost,   up,  step ],
             [leftmost,   up,  enum ],
             [leftmost,   up, bisect],
             [leftmost, down,  step ],
             [leftmost, down,  enum ],
             [leftmost, down, bisect],

             [   ff   ,   up,  step ],
             [   ff   ,   up,  enum ],
             [   ff   ,   up, bisect],
             [   ff   , down,  step ],
             [   ff   , down,  enum ],
             [   ff   , down, bisect],

             [   ffc  ,   up,  step ],
             [   ffc  ,   up,  enum ],
             [   ffc  ,   up, bisect],
             [   ffc  , down,  step ],
             [   ffc  , down,  enum ],
             [   ffc  , down, bisect],

             [   min  ,   up,  step ],
             [   min  ,   up,  enum ],
             [   min  ,   up, bisect],
             [   min  , down,  step ],
             [   min  , down,  enum ],
             [   min  , down, bisect],

             [   max  ,   up,  step ],
             [   max  ,   up,  enum ],
             [   max  ,   up, bisect],
             [   max  , down,  step ],
             [   max  , down,  enum ],
             [   max  , down, bisect]]).

/**
 * Provide All Statistics for All Puzzles
**/
% puzzle_statistics(+Options)
puzzle_statistics(Options) :-
    findall(Difficulty-Id, puzzle(Difficulty, Id, _), Set),
    all_stats(Set, Options).

/**
 * Provide Statistics for the Puzzles
**/
% all_stats(+Puzzles)
all_stats([Puzzle | Puzzles], Options) :-
    stats(Puzzle, Options),
    all_stats(Puzzles, Options).
all_stats([], _).

/**
 * Provide Statistics for one Puzzle
**/
% stats(+Puzzle)
stats(Puzzle, Options) :-
    start_solver(Puzzle, Options, Runtime),
    print_puzzle_stats(Puzzle, Runtime).

/**
 * Similar to start/2 but without the prints
**/
% start_solver(+Puzzle, +LabelingOptions, -Runtime)
start_solver(Difficulty-Id, LabelingOptions, Runtime) :-
    statistics(runtime, [Start | _]),
    solver(Difficulty, Id, LabelingOptions, _),
    statistics(runtime, [Stop | _]),
    Runtime is Stop - Start.

/**
 * Print Puzzle Statistics in a Very Compact Way
**/
% print_puzzle_stats(+Puzzle, +Runtime)
print_puzzle_stats(Difficulty-Id, Runtime) :-
    write(Difficulty),
    write('-'),
    write(Id),
    write(' : '),
    write(Runtime),
    write(' ms\n').

/**
 * Print Puzzle Labeling Options
**/
% print_options(+Options)
print_options([O1, O2, O3]) :-
    write('\nOptions: '),
    write(O1),
    write(' '),
    write(O2),
    write(' '),
    write(O3),
    write('\n').
