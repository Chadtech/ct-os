module Main.Model exposing (..)

import Dict exposing (Dict)
import TextWriter.Model as TextWriter
import Main.Message exposing (Message(..))
import Mouse exposing (Position)


type alias Model =
    { software : Dict String Software
    , mouseMoveMsg : Maybe (Position -> Message)
    }


type Software
    = TextWriter TextWriter.Model
