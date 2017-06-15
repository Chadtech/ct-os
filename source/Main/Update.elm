module Main.Update exposing (update)

import Main.Model exposing (Model)
import Main.Message exposing (Message(..))


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        UpdateField str ->
            Model str ! []

        HandlePort str ->
            Model str ! []
