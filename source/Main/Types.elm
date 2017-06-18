module Main.Types exposing (..)

import Mouse exposing (Position)
import Json.Decode as Decode exposing (Decoder, andThen, fail)
import Json.Decode.Pipeline as Pipeline exposing (required, optional, hardcoded)


type alias Size =
    { width : Int
    , height : Int
    }



-- DECODERS


sizeDecoder : Decoder Size
sizeDecoder =
    Pipeline.decode Size
        |> required "width" Decode.int
        |> required "height" Decode.int


positionDecoder : Decoder Position
positionDecoder =
    Pipeline.decode Position
        |> required "x" Decode.int
        |> required "y" Decode.int
