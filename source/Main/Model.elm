module Main.Model exposing (..)

import Array exposing (Array)
import Main.Message exposing (Message(..))
import Mouse exposing (Position)
import Main.Types.Software exposing (Software(..))
import Json.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder, andThen, fail)
import Json.Decode.Pipeline as Pipeline exposing (required, optional, hardcoded)
import Util exposing ((:=))
import TextWriter.Model as TextWriter
import Tungsten.Model as Tungsten


type alias Model =
    { software : Array Software
    , programsOut : Bool
    , mouseMoveMsg : Maybe (Position -> Message)
    }



-- ENCODER --


encode : Model -> String
encode model =
    let
        software =
            model.software
                |> Array.toList
                |> List.map encodeSoftware
                |> Encode.list
    in
        Encode.object
            [ "software" := software ]
            |> Encode.encode 0


encodeSoftware : Software -> Value
encodeSoftware software =
    case software of
        TextWriter model ->
            Encode.object
                [ "type" := (Encode.string "Text Writer")
                , "body" := TextWriter.encode model
                ]

        Tungsten model ->
            Encode.object
                [ "type" := (Encode.string "Tungsten")
                , "body" := Tungsten.encode model
                ]



-- DECODER --


decoder : Decoder Model
decoder =
    Pipeline.decode Model
        |> required "software" (Decode.array softwareDecoder)
        |> hardcoded False
        |> hardcoded Nothing


softwareDecoder : Decoder Software
softwareDecoder =
    Decode.field "type" Decode.string
        |> andThen softwareDecoderHelp


softwareDecoderHelp : String -> Decoder Software
softwareDecoderHelp type_ =
    case type_ of
        "Text Writer" ->
            TextWriter.decoder
                |> Decode.map TextWriter
                |> Decode.field "body"

        "Tungsten" ->
            Tungsten.decoder
                |> Decode.map Tungsten
                |> Decode.field "body"

        _ ->
            fail "Not a known software type"
