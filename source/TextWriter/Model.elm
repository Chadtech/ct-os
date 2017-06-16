module TextWriter.Model exposing (Model, init)

import Main.Types exposing (Size)
import Mouse exposing (Position)


type alias Model =
    { position : Position
    , size : Size
    , content : String
    , mouseDownPosition : Maybe Position
    }


init : Model
init =
    { position = Position 100 100
    , size = Size 500 500
    , content = ""
    , mouseDownPosition = Nothing
    }
