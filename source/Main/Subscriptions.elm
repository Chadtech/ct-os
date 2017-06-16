module Main.Subscriptions exposing (subscriptions)

import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Mouse


subscriptions : Model -> Sub Message
subscriptions model =
    case model.mouseMoveMsg of
        Just mouseMoveMsg ->
            Sub.batch
                [ Mouse.moves mouseMoveMsg ]

        Nothing ->
            Sub.none
