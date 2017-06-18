module Main.Init exposing (init)

import Main.Model as Model exposing (Model)
import Main.Message exposing (Message(..))
import Array
import Json.Decode as Decode exposing (Value)
import Debug exposing (log)


init : Value -> ( Model, Cmd Message )
init json =
    case Decode.decodeValue Model.decoder json of
        Ok model ->
            ( model, cmd )

        Err err ->
            let
                _ =
                    log "err" err
            in
                ( blank, cmd )


blank : Model
blank =
    { software = Array.empty
    , programsOut = False
    , mouseMoveMsg = Nothing
    }


cmd : Cmd Message
cmd =
    Cmd.none
