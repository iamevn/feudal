require "util"

-- I'm sorry
local baseboards = {
    {{"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "rough", "mountain", "mountain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"mountain", "plain", "rough", "mountain", "plain", "mountain", "mountain", "mountain", "plain", "plain", "plain", "plain"}, {"mountain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain", "rough", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "rough", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}},
    {{"plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "mountain", "plain", "plain", "rough", "plain"}, {"mountain", "plain", "plain", "plain", "plain", "plain", "rough", "plain", "plain", "plain", "mountain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "mountain", "mountain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "rough", "mountain", "mountain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "mountain", "mountain", "rough", "plain", "plain", "mountain", "mountain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}},
    {{"plain", "plain", "plain", "plain", "plain", "mountain", "rough", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "mountain", "mountain", "plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "plain"}, {"plain", "mountain", "plain", "plain", "mountain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "mountain", "rough", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "mountain", "mountain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "mountain", "rough", "plain", "plain", "plain", "plain"}, {"plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}},
    {{"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "mountain", "plain", "plain", "plain", "rough", "mountain", "plain", "plain", "mountain", "plain"}, {"plain", "plain", "mountain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "mountain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "mountain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "mountain", "rough", "plain", "plain", "rough", "plain", "plain", "plain"}, {"plain", "mountain", "plain", "plain", "plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "rough"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}, {"plain", "mountain", "mountain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain", "plain"}}
 }

 -- TODO: add support for randomly generated boards
 function createBoard()
     local tmp = {}

     for bd in range(4) do
         tmp[bd] = {}
         for y in range(12) do
             tmp[bd][y] = {}
             for x in range(12) do
                 tmp[bd][y][x] = baseboards[bd][y][x]
             end
         end
     end
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
     -- return tmpboards
     local tmp2 = {}
     for bd in range(4) do
         tmp2[bd] = {}
         for y in range(12) do
             tmp2[bd][y] = {}
             for x in range(12) do
                 tmp2[bd][y][x] = tmpboards[bd][y][x]
             end
         end
     end

     return tmp2
 end

 -- given a board and a board segment index
 -- return a new board with that segment rotated 90 degrees clockwise
 function rotateSegment(board, n)
     print("Rotating segment "..n.."\n")
     local tmpsegment = {}
     for y in range(12) do
         tmpsegment[y] = {}
     end
     for y in range(12) do
         local col = 12 - y + 1
         for x in range(12) do
             local row = x
             tmpsegment[row][col] = board[n][y][x]
         end
     end

     local tmp = {}

     for bd in range(4) do
         tmp[bd] = {}
         for y in range(12) do
             tmp[bd][y] = {}
             for x in range(12) do
                 tmp[bd][y][x] = board[bd][y][x]
             end
         end
     end

     tmp[n] = tmpsegment
     return tmp
 end

 function combineSegments(splitboard)
     local boardres = 12
     local tmpboard = {}
     for y in range(boardres) do
         tmpboard[y] = {}
         for x in range(boardres) do
             table.insert(tmpboard[y], splitboard[1][y][x])
         end
     end

     for y in range(boardres) do
         tmpboard[y + boardres] = splitboard[3][y]
         for x in range(boardres) do
             table.insert(tmpboard[y], boardres + x, splitboard[2][y][x])
             table.insert(tmpboard[y + boardres], boardres + x, splitboard[4][y][x])
         end
     end
     return tmpboard
 end
