module Main.Init exposing (model, cmd)

import Main.Model exposing (Model)
import Main.Message exposing (Message(..))


model : Model
model =
    Model ""


cmd : Cmd Message
cmd =
    Cmd.none
