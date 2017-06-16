module Main.Update exposing (update)

import Main.Model exposing (Model, Software(..))
import Main.Message exposing (Message(..))
import Dict
import TextWriter.Update as TextWriter


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        TextWriterMessage name subMessage ->
            case Dict.get name model.software of
                Just (TextWriter subModel) ->
                    let
                        ( newSubModel, changeMouseMsg, keep, cmd ) =
                            TextWriter.update subMessage subModel

                        newMouseMsg =
                            case changeMouseMsg of
                                Just maybeMouseMsg ->
                                    case maybeMouseMsg of
                                        Just mouseMsg ->
                                            Just (TextWriterMessage name << mouseMsg)

                                        Nothing ->
                                            Nothing

                                Nothing ->
                                    model.mouseMoveMsg
                    in
                        if keep then
                            { model
                                | software =
                                    Dict.insert
                                        name
                                        (TextWriter newSubModel)
                                        model.software
                                , mouseMoveMsg = newMouseMsg
                            }
                                ! [ Cmd.map (TextWriterMessage name) cmd ]
                        else
                            { model
                                | software =
                                    Dict.remove name model.software
                            }
                                ! []

                _ ->
                    model ! []
