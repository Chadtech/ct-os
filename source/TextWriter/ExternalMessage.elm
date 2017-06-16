module TextWriter.ExternalMessage exposing (..)

import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import TextWriter.Message as TextWriter
import Mouse exposing (Position)
import Array.Extra


type ExternalMessage
    = Delete
    | TrackMouseMovements (Position -> TextWriter.Message)
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
                    Just ((TextWriterMessage index) << toMsg)
            }

        StopTrackingMouseMovements ->
            { model | mouseMoveMsg = Nothing }
