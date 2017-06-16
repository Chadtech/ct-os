module TextWriter.Update exposing (update)

import TextWriter.Model exposing (Model)
import TextWriter.Message exposing (Message(..))
import TextWriter.ExternalMessage exposing (ExternalMessage(..))
import Mouse exposing (Position)


update : Message -> Model -> ( Model, Maybe ExternalMessage, Cmd Message )
update message model =
    case message of
        SetContent newContent ->
            let
                newModel =
                    { model
                        | content = newContent
                    }
            in
                ( newModel, Nothing, Cmd.none )

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

        Close ->
            ( model
            , Just Delete
            , Cmd.none
            )
