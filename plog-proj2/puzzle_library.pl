/**
* Library of Puzzles for Tricky Triple
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
* Board -> a list of lists representative of a puzzle instance of tricky triple
*       Board Cells Numeric Representation:
*           0 - BALCK CELL
*           1 - Green Triangle
*           2 - Red Square
*           3 - Blue Circle
*/
% puzzle(+Difficulty, +Id, -Board)

/**
*---------------------------------------------------------
*----   Puzzles of Difficulty 1 <-> Dimension 4x4   -------
*---------------------------------------------------------*/

puzzle(1, 1,[
    [_, _, 1, _],
    [2, _, 1, _],
    [_, _, _, 2],
    [_, 2, _, 3]
    ]).

puzzle(1, 2,[
    [1, _, 3, _],
    [_, _, _, _],
    [2, _, 3, 1],
    [_, _, 2, _]
    ]).

puzzle(1, 3,[
    [2, 1, _, _],
    [_, 3, _, 3],
    [_, _, _, 3],
    [2, _, _, _]
    ]).

puzzle(1, 4,[
    [_, _, _, 2],
    [_, _, _, _],
    [1, 2, _, 2],
    [_, _, 2, 3]
    ]).

puzzle(1, 5,[
    [_, 1, _, 2],
    [_, _, _, _],
    [_, _, 3, 2],
    [3, _, _, 1]
    ]).

puzzle(1, 6,[
    [2, 2, _, _],
    [_, _, _, _],
    [3, _, _, 1],
    [_, 3, 1, _]
    ]).

puzzle(1, 7,[
    [_, 3, 1, _],
    [_, _, 2, _],
    [_, 3, 1, _],
    [_, 2, _, _]
    ]).

/**
*---------------------------------------------------------
*----   Puzzles of Difficulty 2 <-> Dimension 5x5   -------
*---------------------------------------------------------*/

puzzle(2, 1,[
    [_, 1, 3, _, 3],
    [1, _, _, 0, 2],
    [_, _, _, _, 0],
    [2, _, _, _, _],
    [3, _, _, _, _]
    ]).

puzzle(2, 2,[
    [_, 2, _, 1, _],
    [_, _, _, _, _],
    [1, _, _, _, 2],
    [_, _, 0, _, _],
    [3, 2, _, 3, 1]
    ]).

puzzle(2, 3,[
    [_, _, 2, _, 2],
    [_, 1, _, _, _],
    [_, 1, 0, _, 3],
    [1, _, 3, 1, _],
    [_, _, _, _, _]
    ]).

puzzle(2, 4,[
    [2, _, 2, _, 2],
    [3, _, 2, _, _],
    [0, _, _, 1, _],
    [_, _, _, _, _],
    [_, _, _, 3, 2]
    ]).

puzzle(2, 5,[
    [3, 2, _, 1, _],
    [_, _, 1, _, 3],
    [_, _, _, _, _],
    [_, _, _, _, 0],
    [1, _, _, _, 3]
    ]).

puzzle(2, 6,[
    [_, _, 2, _, _],
    [_, 0, 1, _, _],
    [_, 3, _, 1, _],
    [_, _, _, _, 2],
    [_, 2, 2, _, _]
    ]).

puzzle(2, 7,[
    [1, _, _, 2, 3],
    [_, _, _, _, 1],
    [_, _, _, _, _],
    [1, _, _, _, 2],
    [_, _, 1, _, _]
    ]).