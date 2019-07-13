module Ch04 where

import System.Environment


myMain = mainWith myFunction
    where 
        mainWith function = do
            args <- getArgs
            case args of
                [input, output] -> interactWith function input output
                _ -> putStrLn "error: exactly 2 arguments needed"    
        myFunction = fixLines

fixLines :: String -> String
fixLines input = unlines $ splitLines input

splitLines :: String -> [String]
splitLines [] = []
splitLines cs = 
    let (pre, suf) = break isLineTerminator cs
    in pre : case suf of
        ('\r':'\n':rest) -> splitLines rest
        ('\r':rest)      -> splitLines rest
        ('\n':rest)      -> splitLines rest
        _                -> []

isLineTerminator c = c == '\r' || c == '\n'

interactWith function inputFile outputFile = do
    input <- readFile  inputFile
    writeFile outputFile $ function input