module Game_logic(fillCellList, lifeStep) where

import Types
import Data.List
import System.IO.Unsafe

fillCellList :: AliveCells
fillCellList = [(1, 0), (2, 1), (0, 2), (1, 2), (2, 2), (18, 0), (18, 1), (18, 2)]--[(3, 5), (4, 5), (5, 5), (6, 5)]
--fillCellList = unsafePerformIO fH

fH :: IO(AliveCells)
fH = do
        src <- readFile "file.in"
        return (operate src)

operate :: String -> AliveCells
operate str = [(x, y) | x <- odd1 m, y <- even1 m]
        where m = charToInt str 0

odd1 :: [Int] -> [Int]
odd1 [] = []
odd1 (x:[]) = [x]
odd1 (x:y:xs) = x:(odd1 xs)

even1 :: [Int] -> [Int]
even1 [] = []
even1 (x:[]) = []
even1 (x:y:xs) = y:(even1 xs)

charToInt :: String -> Int -> [Int]
charToInt [] s = [s]
charToInt (x:xs) s
                | (x == ' ') && (s == 0) = charToInt xs 0
                | (x == ' ') =  s:(charToInt xs 0)
                | otherwise = charToInt xs (s * 10 + (fromEnum x))

lifeStep :: AliveCells -> AliveCells
lifeStep cells = [head g | g <- makeSurround cells, checkSurround g cells]

checkSurround :: AliveCells -> AliveCells -> Bool
checkSurround [_, _, _] _ = True
checkSurround [x, _] cells = x `elem` cells
checkSurround _ _ = False

makeSurround :: AliveCells -> [AliveCells]
makeSurround = group . sort . concatMap surrounding

surrounding :: (Int, Int) -> AliveCells
surrounding (x, y) = [(x+dx, y+dy) | dx <- [-1..1], dy <- [-1..1], (dx,dy) /= (0,0)]

