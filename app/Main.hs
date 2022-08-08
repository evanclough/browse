module Main where

import Prelude
import qualified Data.Map as Map
import HaskellSay (haskellSay)
import System.IO
import System.Exit (exitSuccess)
import System.Console.ANSI

import HtmlParser

help :: [String] -> IO ()
help _ = putStrLn $ "help               | prints list of commands.\n" ++ 
                    "exit               | exits the program.\n" ++
                    "parseLocal fileName| parses locally stored html, assuming the file you want to parse is in the html \n" ++
                    "                   | folder in the root directory. mostly for testing.\n" ++ 
                    "fetch URL          | given some URL, parses the html into something that is hopefully readable.\n" ++
                    "clear              | clears the screen"

parseLocal :: [String] -> IO ()
parseLocal [fileName] = do  clearScreen
                            setCursorPosition 0 0
                            html <- readFile $ "html/" ++ fileName 
                            putStrLn $ parseHtml html


fetch :: [String] -> IO ()
fetch args = putStrLn "hi"

commandMap :: Map.Map String ([String] -> IO ())
commandMap = Map.fromList [
    ("help", help), 
    ("exit", \lst -> exitSuccess),
    ("parseLocal", parseLocal),
    ("fetch", fetch),
    ("clear", \lst -> clearScreen)
    ]

parseInput :: String -> IO ()
parseInput [] = putStrLn "You forgot to enter a command :("
parseInput inp =    case isValidCmd of  Nothing -> putStrLn $ "invalid command: " ++ (head $ words inp)
                                        Just f -> f $ tail $ words inp
                    where isValidCmd = Map.lookup (head $ words inp) commandMap

inputLoop :: IO ()
inputLoop = do  putChar '>'
                hFlush stdout
                inp <- getLine
                parseInput inp
                inputLoop

main :: IO ()
main =  do  setSGR  [   SetConsoleIntensity BoldIntensity,
                        SetColor Foreground Vivid Red
                        ]       
            haskellSay "Welcome to Browse! Enter 'help' for a list of commands!"
            putStrLn "\n"
            inputLoop
