module Main.Init exposing (model, cmd)

import Main.Model exposing (Model)
import Main.Types.Software exposing (Software(..))
import Main.Message exposing (Message(..))
import TextWriter.Model as TextWriter
import Array


model : Model
model =
    { software =
        Array.fromList
            [ TextWriter (TextWriter.init "") ]
    , mouseMoveMsg = Nothing
    }


cmd : Cmd Message
cmd =
    Cmd.none
