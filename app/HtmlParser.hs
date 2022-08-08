{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ViewPatterns      #-}

module HtmlParser where

import Control.Applicative

-- string input with integer that keeps track
-- of the character you're on in the original string
data Input = Input
  { inputLoc :: Int
  , inputStr :: String
  } deriving (Show, Eq)

-- Takes one character from the input and returns nothing
-- if there's nothing to take.
inputUncons :: Input                  
            -> Maybe (Char, Input)
inputUncons (Input _ [])       = Nothing
inputUncons (Input loc (x:xs)) = Just (x, Input (loc + 1) xs)

type tagName = String
type textContent = String

data HtmlElement =  Leaf tagName textContent | Branch tagName HtmlElement 
                    deriving (Show, Eq)

data ParserResult = Failure | Success String String

parseHtml :: String -> String
parseHtml fileContents = fileContents