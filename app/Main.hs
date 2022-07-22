module Main where

import Prelude hiding (lookup)
import Data.Map 

help :: [String] -> IO ()
help _ = putStrLn "the commands are: "

commandMap :: Map String ([String] -> IO ())
commandMap = fromList [("help", help)]

parseInput :: String -> IO ()
parseInput inp = case isValidCmd of Nothing -> putStrLn $ "invalid command: " ++ (head $ words inp)
                                    Just f -> f $ tail $ words inp
                                    where isValidCmd = lookup (head $ words inp) commandMap

main :: IO ()
main =  do
            inp <- getLine
            parseInput inp
            main
