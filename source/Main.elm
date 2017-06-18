module Main exposing (..)

import Html
import Main.Init exposing (init)
import Main.View exposing (view)
import Main.Subscriptions exposing (subscriptions)
import Main.Update exposing (update)
import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Json.Decode exposing (Value)


main : Program Value Model Message
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
