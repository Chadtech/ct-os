module Main.View exposing (view)

import Html exposing (Html, div, p, a, text)
import Html.Attributes exposing (class, style)
import Main.Model exposing (Model, Software(..))
import Main.Message exposing (Message(..))
import TextWriter.View as TextWriter
import Dict


view : Model -> Html Message
view model =
    List.concat
        [ [ startBar model ]
        , softwareWindows model
        ]
        |> div [ class "main" ]


startBar : Model -> Html Message
startBar { software } =
    let
        start =
            a [] [ text "start" ]
    in
        (start :: List.map softwareTab (Dict.toList software))
            |> div [ class "start-bar" ]


softwareTab : ( String, Software ) -> Html Message
softwareTab ( name, _ ) =
    a
        [ class "selected" ]
        [ text name ]


softwareWindows : Model -> List (Html Message)
softwareWindows =
    .software >> Dict.toList >> List.map softwareWindow


softwareWindow : ( String, Software ) -> Html Message
softwareWindow ( name, software ) =
    case software of
        TextWriter model ->
            Html.map
                (TextWriterMessage name)
                (TextWriter.view name model)
