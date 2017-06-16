module Main.Model exposing (..)

import Array exposing (Array)
import Main.Message exposing (Message(..))
import Mouse exposing (Position)
import Main.Types.Software exposing (Software(..))


type alias Model =
    { software : Array Software
    , mouseMoveMsg : Maybe (Position -> Message)
    }
