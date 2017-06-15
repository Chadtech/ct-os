module Main.Message exposing (Message(..), Handler)


type Message
    = UpdateField String
    | HandlePort String


type alias Handler a =
    a -> Message
