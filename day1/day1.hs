import System.IO
import Data.List.Split
import Data.List


main :: IO ()
main = do
  input <- openFile "input1.txt" ReadMode
  calories <- hGetContents input

  let sumsSorted = sort . map (sum . map (read::String->Int) . filter (/="") . splitOn "\n") $ splitOn "\n\n" calories

  putStrLn $ show . last $ sumsSorted -- part 1
  putStrLn $ show . sum . take 3 . reverse $ sumsSorted -- part 2

  hClose input
