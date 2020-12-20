/**
* Library of Solutions of Puzzles for Tricky Triple
* available on "https://erich-friedman.github.io/puzzle/shape/"
*
* Difficulty -> directly connected to the dimensions of the puzzle
*       1 - 4x4
*       2 - 5x5
*       3 - 6x6
*       4 - 7x7
*
* Id -> numeric identifier of puzzle instance within a difficulty
*
* Solution -> a list of lists representative of the solution of a puzzle instance of tricky triple.
*       Solution Cells Numeric Representation:
*           0 - BALCK CELL
*           1 - Green Triangle
*           2 - Red Square
*           3 - Blue Circle
*/ 
% puzzle_solution(+Difficulty, +Id, -Solution)

/**
*---------------------------------------------------------
*- Solutions of Puzzles of Difficulty 1 <-> Dimension 4x4 -
*---------------------------------------------------------*/

puzzle_solution(1, 1,[
    [3, 1, 1, 2],
    [2, 1, 1, 3],
    [3, 2, 3, 2],
    [2, 2, 3, 3]
    ]).

puzzle_solution(1, 2,[
    [1, 1, 3, 3],
    [2, 3, 2, 3],
    [2, 3, 3, 1],
    [3, 2, 2, 1]
    ]).

puzzle_solution(1, 3,[
    [2, 1, 1, 2],
    [3, 3, 1, 3],
    [3, 1, 3, 3],
    [2, 1, 1, 2]
    ]).

puzzle_solution(1, 4,[
    [3, 2, 3, 2],
    [1, 3, 1, 3],
    [1, 2, 1, 2],
    [2, 3, 2, 3]
    ]).

puzzle_solution(1, 5,[
    [1, 1, 2, 2],
    [2, 1, 2, 1],
    [2, 3, 3, 2],
    [3, 1, 3, 1]
    ]).

puzzle_solution(1, 6,[
    [2, 2, 1, 1],
    [2, 3, 2, 3],
    [3, 2, 2, 1],
    [3, 3, 1, 3]
    ]).

puzzle_solution(1, 7,[
    [1, 3, 1, 3],
    [3, 2, 2, 1],
    [1, 3, 1, 3],
    [3, 2, 2, 1]
    ]).