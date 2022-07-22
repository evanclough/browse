module HtmlParser where

data ParserResult = Failure | Success String String

type Parser = String -> ParserResult

returnString :: String -> Parser
returnString str = \inp -> Success str inp

failure :: Parser
failure = \inp -> Failure

take1Char :: Parser
take1Char = \inp -> Success [(head inp)] (tail inp)

parseHtml :: String -> String
parseHtml fileContents = fileContents