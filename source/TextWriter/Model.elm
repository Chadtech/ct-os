module TextWriter.Model exposing (..)

import Main.Types exposing (Size)
import Mouse exposing (Position)


type alias Model =
    { position : Position
    , size : Size
    , content : String
    , mouseDownPosition : Maybe Position
    , title : String
    }


blank : Model
blank =
    init ""


init : String -> Model
init initContent =
    { position = Position 100 100
    , size = Size 500 500
    , content = initContent
    , mouseDownPosition = Nothing
    , title = "Text Writer"
    }
