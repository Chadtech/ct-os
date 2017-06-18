module Tungsten.Update exposing (update)

import Tungsten.Model exposing (Model)
import Tungsten.Message exposing (Message(..))
import Tungsten.ExternalMessage exposing (ExternalMessage(..))
import Mouse exposing (Position)


update : Message -> Model -> ( Model, Maybe ExternalMessage, Cmd Message )
update message model =
    case message of
        SetPosition { x, y } ->
            let
                { mouseDownPosition } =
                    model

                newModel =
                    case model.mouseDownPosition of
                        Just position ->
                            { model
                                | position =
                                    Position
                                        (x - position.x)
                                        (y - position.y)
                            }

                        Nothing ->
                            model
            in
                ( newModel, Nothing, Cmd.none )

        TitleMouseDown { targetPos, clientPos } ->
            let
                x =
                    clientPos.x - targetPos.x

                y =
                    clientPos.y - targetPos.y

                newModel =
                    { model
                        | mouseDownPosition = Just (Position x y)
                    }
            in
                ( newModel
                , Just (TrackMouseMovements SetPosition)
                , Cmd.none
                )

        TitleMouseUp ->
            let
                newModel =
                    { model
                        | mouseDownPosition = Nothing
                    }
            in
                ( newModel
                , Just (StopTrackingMouseMovements)
                , Cmd.none
                )

        SetUrlField str ->
            let
                newModel =
                    { model
                        | urlField =
                            str
                    }
            in
                ( newModel, Nothing, Cmd.none )

        GoToUrl ->
            let
                newUrl =
                    if String.left 6 model.urlField == "http://" then
                        model.urlField
                    else
                        "http://" ++ model.urlField

                newModel =
                    { model
                        | url = newUrl
                        , urlField = newUrl
                    }
            in
                ( newModel
                , Nothing
                , Cmd.none
                )

        Close ->
            ( model
            , Just Delete
            , Cmd.none
            )
