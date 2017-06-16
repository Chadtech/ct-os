module Main.Update exposing (update)

import Main.Model exposing (Model)
import Main.Types.Software exposing (Software(..))
import Main.Message exposing (Message(..))
import TextWriter.Update as TextWriter
import TextWriter.ExternalMessage as TextWriter
import Array
import Util exposing (packWith)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        New software ->
            { model
                | software =
                    Array.push
                        software
                        model.software
            }
                ! []

        TextWriterMessage index subMessage ->
            case Array.get index model.software of
                Just (TextWriter subModel) ->
                    let
                        ( newSubModel, maybeExternalMsg, cmd ) =
                            TextWriter.update subMessage subModel
                    in
                        { model
                            | software =
                                Array.set
                                    index
                                    (TextWriter newSubModel)
                                    model.software
                        }
                            |> TextWriter.handle index maybeExternalMsg
                            |> packWith
                                (Cmd.map (TextWriterMessage index) cmd)

                _ ->
                    model ! []


getName : Int -> List String -> String
getName i names =
    let
        name =
            "text writer" ++ (toString i)
    in
        if List.member name names then
            getName (i + 1) names
        else
            name
