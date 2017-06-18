module Main.Update exposing (update)

import Main.Model as Model exposing (Model)
import Main.Types.Software exposing (Software(..))
import Main.Message exposing (Message(..))
import TextWriter.Update as TextWriter
import TextWriter.ExternalMessage as TextWriter
import Tungsten.Update as Tungsten
import Tungsten.ExternalMessage as Tungsten
import Array
import Array.Extra
import Util exposing (packWith)
import Ports


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        Save ->
            ( model, Ports.save (Model.encode model) )

        New software ->
            { model
                | software =
                    Array.push
                        software
                        model.software
                , programsOut = False
            }
                ! []

        TextWriterMessage index subMessage ->
            case Array.get index model.software of
                Just (TextWriter subModel) ->
                    let
                        ( newSubModel, maybeExternalMsg, cmd ) =
                            TextWriter.update subMessage subModel
                    in
                        model
                            |> putOnTop index (TextWriter newSubModel)
                            |> TextWriter.handle 0 maybeExternalMsg
                            |> packWith
                                (Cmd.map (TextWriterMessage 0) cmd)

                _ ->
                    model ! []

        TungstenMessage index subMessage ->
            case Array.get index model.software of
                Just (Tungsten subModel) ->
                    let
                        ( newSubModel, maybeExternalMsg, cmd ) =
                            Tungsten.update subMessage subModel
                    in
                        model
                            |> putOnTop index (Tungsten newSubModel)
                            |> Tungsten.handle 0 maybeExternalMsg
                            |> packWith
                                (Cmd.map (TungstenMessage 0) cmd)

                _ ->
                    model ! []

        BringProgramsOut ->
            let
                newModel =
                    if model.programsOut then
                        { model
                            | programsOut = False
                        }
                    else
                        { model
                            | programsOut = True
                        }
            in
                ( newModel, Cmd.none )


putOnTop : Int -> Software -> Model -> Model
putOnTop index s model =
    { model
        | software =
            model.software
                |> Array.Extra.removeAt index
                |> Array.toList
                |> (::) s
                |> Array.fromList
    }
