module Main.View exposing (view)

import Html exposing (Html, div, p, a, text)
import Html.Attributes exposing (class, classList, style)
import Main.Model exposing (Model)
import Main.Types.Software exposing (Software(..))
import Main.Message exposing (Message(..))
import TextWriter.View as TextWriter
import Array


view : Model -> Html Message
view model =
    List.concat
        [ [ startBar model ]
        , softwareWindows model
        ]
        |> div [ class "main" ]


startBar : Model -> Html Message
startBar { software } =
    software
        |> Array.map softwareTab
        |> Array.toList
        |> div [ class "start-bar" ]


softwareTab : Software -> Html Message
softwareTab software =
    let
        title =
            case software of
                TextWriter model ->
                    model.title
    in
        a
            []
            [ text title ]


softwareWindows : Model -> List (Html Message)
softwareWindows =
    .software
        >> Array.indexedMap softwareWindow
        >> Array.toList


softwareWindow : Int -> Software -> Html Message
softwareWindow index software =
    case software of
        TextWriter model ->
            Html.map
                (TextWriterMessage index)
                (TextWriter.view index model)
