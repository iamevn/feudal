require "util"

-- I'm sorry
local baseboards = {
    {{"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "rough", "mountain", "mountain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"mountain", "plain", "rough", "mountain", "plain", "mountain", "mountain", "mountain", "plain", "plain", "plain", "plain"}, {"mountain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain", "rough", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "rough", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}},
    {{"plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "mountain", "plain", "plain", "rough", "plain"}, {"mountain", "plain", "plain", "plain", "plain", "plain", "rough", "plain", "plain", "plain", "mountain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "mountain", "mountain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "rough", "mountain", "mountain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "mountain", "mountain", "rough", "plain", "plain", "mountain", "mountain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}},
    {{"plain", "plain", "plain", "plain", "plain", "mountain", "rough", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "mountain", "mountain", "plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "plain"}, {"plain", "mountain", "plain", "plain", "mountain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "mountain", "rough", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "mountain", "mountain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "mountain", "rough", "plain", "plain", "plain", "plain"}, {"plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}},
    {{"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "mountain", "plain", "plain", "plain", "rough", "mountain", "plain", "plain", "mountain", "plain"}, {"plain", "plain", "mountain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "mountain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "mountain", "rough", "plain", "plain", "rough", "plain", "plain", "plain"}, {"plain", "mountain", "plain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "rough"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "mountain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}}
 }

 function createBoard()
     return baseboards
 end

 -- given a board and two board segment indicies,
 -- return new board with those two swapped
 function swapSegments(board, a, b)
     local tmpboards = {}

     tmpboards[1] = board[1]
     tmpboards[2] = board[2]
     tmpboards[3] = board[3]
     tmpboards[4] = board[4]
     tmpboards[a] = board[b]
     tmpboards[b] = board[a]
     return tmpboards
 end

 -- given a board and a board segment index
 -- return a new board with that segment rotated 90 degrees clockwise
 function rotateSegment(board, n)
     local tmpsegment = {}
     for y in range(#board[n]) do
         tmpsegment[y] = {}
     end
     for y in range(#board[n]) do
         local col = #board[n][y] - y + 1
         for x in range(#board[n][y]) do
             local row = x
             tmpsegment[row][col] = board[y][x]
         end
     end
 end
