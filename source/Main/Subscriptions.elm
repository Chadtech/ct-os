module Main.Subscriptions exposing (subscriptions)

import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Ports exposing (..)


subscriptions : Model -> Sub Message
subscriptions model =
    fromJS HandlePort
