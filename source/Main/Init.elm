module Main.Init exposing (model, cmd)

import Main.Model exposing (Model, Software(..))
import Main.Message exposing (Message(..))
import TextWriter.Model as TextWriter
import Dict
import Util exposing ((:=))


model : Model
model =
    { software =
        Dict.fromList
            [ "text writer" := TextWriter TextWriter.init ]
    , mouseMoveMsg = Nothing
    }


cmd : Cmd Message
cmd =
    Cmd.none
