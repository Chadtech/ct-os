module Tungsten.Model exposing (..)

import Main.Types exposing (Size)
import Main.Types exposing (Size, sizeDecoder, positionDecoder)
import Mouse exposing (Position)
import Json.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder, andThen, fail)
import Json.Decode.Pipeline as Pipeline exposing (custom, required, optional, hardcoded)
import Util exposing ((:=))


type alias Model =
    { position : Position
    , size : Size
    , url : String
    , urlField : String
    , mouseDownPosition : Maybe Position
    , title : String
    }


blank : Model
blank =
    init ""


init : String -> Model
init initContent =
    { position = Position 125 125
    , size = Size 800 600
    , url = initContent
    , urlField = initContent
    , mouseDownPosition = Nothing
    , title = "Tungsten Internet Browser"
    }



-- ENCODER


encode : Model -> Value
encode model =
    Encode.object
        [ "x" := Encode.int model.position.x
        , "y" := Encode.int model.position.y
        , "width" := Encode.int model.size.width
        , "height" := Encode.int model.size.height
        , "url" := Encode.string model.url
        , "title" := Encode.string model.title
        ]



-- DECODER --


decoder : Decoder Model
decoder =
    Pipeline.decode Model
        |> custom positionDecoder
        |> custom sizeDecoder
        |> required "url" Decode.string
        |> required "url" Decode.string
        |> hardcoded Nothing
        |> required "title" Decode.string
