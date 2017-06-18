module Tungsten.ExternalMessage exposing (..)

import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Tungsten.Message as Tungsten
import Mouse exposing (Position)
import Array.Extra


type ExternalMessage
    = Delete
    | TrackMouseMovements (Position -> Tungsten.Message)
    | StopTrackingMouseMovements


handle : Int -> Maybe ExternalMessage -> Model -> Model
handle index maybeMessage model =
    case maybeMessage of
        Nothing ->
            model

        Just message ->
            handleMessage index message model


handleMessage : Int -> ExternalMessage -> Model -> Model
handleMessage index message model =
    case message of
        Delete ->
            { model
                | software =
                    Array.Extra.removeAt index model.software
            }

        TrackMouseMovements toMsg ->
            { model
                | mouseMoveMsg =
                    Just ((TungstenMessage index) << toMsg)
            }

        StopTrackingMouseMovements ->
            { model | mouseMoveMsg = Nothing }
