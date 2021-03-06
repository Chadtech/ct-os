module TextWriter.Model exposing (..)

import Main.Types exposing (Size, sizeDecoder, positionDecoder)
import Mouse exposing (Position)
import Json.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder, andThen, fail)
import Json.Decode.Pipeline as Pipeline exposing (custom, required, optional, hardcoded)
import Util exposing ((:=))


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



-- ENCODER --


encode : Model -> Value
encode model =
    Encode.object
        [ "x" := Encode.int model.position.x
        , "y" := Encode.int model.position.y
        , "width" := Encode.int model.size.width
        , "height" := Encode.int model.size.height
        , "content" := Encode.string model.content
        , "title" := Encode.string model.title
        ]



-- DECODER --


decoder : Decoder Model
decoder =
    Pipeline.decode Model
        |> custom positionDecoder
        |> custom sizeDecoder
        |> required "content" Decode.string
        |> hardcoded Nothing
        |> required "title" Decode.string
